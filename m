Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BD1CF07C4
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 08:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A4910E2B3;
	Thu, 10 Oct 2024 08:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nweAMRqd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07F210E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffrRVee8eXGL9Rardcof4nunDNamYvO2dRgloqU0GNlX0Ns7ZoT4fwWyTaD+Z7WkKVRYDqp/om1qqJtPPNig5S8j5w6tcDDH2n7odBQWSjaHyUQ1rJyEWTZHfhIR8Vx9Iqe/AVwtd04Gw0svRndkAyaDAiQmKkA2Lp+yikH4sjJzDvAMzCVc9lIlQ9hVLZroeucJbvtXG/5s9tyvyKT2sdrZr591MRWeXn3U/yViAb42HvsXRX6RkKTsGTf/6WIK0SjPILoCHU5PAZMeF6AhXhy4LyMEM8y6M0LM59qZfb2DikYBAesQC1BwMHYne+vkQqCPGa7Z7NI+dbcln3VwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw4ogTHNgX+5T1zPVzL5LprZVxC1RNK/Oe4qs432lHA=;
 b=mUgKqsnPCQUt/f5rclg5oxKY+0+xo0EFIPEsmwVDHmvB/RxFonNwQQJxSVDCpgdgxOVISu9GoqrfAjd6rvM2ZBSSF4da7ZgpHgYbDaQ8Ia3WlNfYctzUBDvKqMUzNUYESDb4T3TnA+5lvttafrEScWLsOfL3HP72jD+3p1OO242M8wDDJlUFh5diOqwSrFeZsEV4kCrwWD8Oh+7IV/BeK8XewkDYqgmrrQ85qful+5E7qxi3PnDxZkyZplJrQ9O7VFhLxIL7qIe59SQuZNZEYR4Xbe73A4J3Q66RR2uTwC90SCcsKSEQbvVy63rsbm0WxvdryCe8eYODb6titV/Sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw4ogTHNgX+5T1zPVzL5LprZVxC1RNK/Oe4qs432lHA=;
 b=nweAMRqdo+VYHK8g1O698xS5R6ntI4+mjHJ+F0SndyZGWA/TbYsFxlEtl1kNLGTDwqPJqmxZK43Mjkg58eI/2ertO3bNGykOAGxE7wDpRhM9bSCNJ9Tcc4oGccrTsrg5E4ATrKMemQFPDFcHhC7LWf1UibKfxjgx1CYYgsMd/dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 08:35:29 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 08:35:29 +0000
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
 <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <85fe3fd1-53e3-2c00-d27c-96ed595634b3@amd.com>
Date: Thu, 10 Oct 2024 14:05:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: e11da9d6-1203-493f-81c1-08dce9067f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGdUZ3hWaE9ueDMzWmJ5Mjg1cEtPeDE3U3VvcjdsTklIT1A1UEZWZVpvS3Qv?=
 =?utf-8?B?bXNyQ2h4T3Z4YWRDNGxEbU95eGdzSUVHYkJjd0hWS3NDdFRwL1cyZHJFM3E3?=
 =?utf-8?B?MUh2blNyRGVOYUxPSWRnaDFCaURQS28vNkttampqN0wzdTZvSTJMcVA3WTg5?=
 =?utf-8?B?Z0REU0dsSXgwQ2E2OXM0Y1BZVGxwV2R4YXhYQ2cwNXplMTRWSHJNRzVteXFu?=
 =?utf-8?B?a0d4Ky9MMDR4QTlwM1YzbzhjNUl1b1RLQlZLbFJ1Q2hzb0tHY3duTzdmdGQ3?=
 =?utf-8?B?NGI0a2g1YXl3MndmbWJyWTJkcm0ybHNGZ0FQSkxqOGRhM0xJR01sMUhRUzh3?=
 =?utf-8?B?aVVaYW44NGRodGtkTi9tNTgxUFdNeFFMZnlrTC83QlM3TS9zOFcvSUxOenVt?=
 =?utf-8?B?R05NM1U1VWNTbEtqVEJhMmVMREdrdkh1c25TdVBoSUloSkRkU0NoMjRkdC9G?=
 =?utf-8?B?NXBkV0wrVExXZ052OGNvWGJ3UzM3a0FveFkzOGhaWkNGdlMxc01oSVl6Tit0?=
 =?utf-8?B?Mko5Z3dFNHpTcnl6VWRSNmJZZU9jZlRCUWZCM01wdWRRdXFQVDQyV3VqOUxU?=
 =?utf-8?B?L3gxUVpjdDlQRjF6Wk9Hd09ZREpNMXBISGZPS3ZRakdsYTBBMFdocVovUm9G?=
 =?utf-8?B?UWRjcURjdVRJVGM1NVdKNmlwdkZsdDVtUkd6eEo2Mi8raHhmNFE5ZlRZZEFx?=
 =?utf-8?B?TkxsenVyamFGVktrQ1VLWGRiTjdrV29kR2svZkJQcU9pNkpnMnVzYUgzekdT?=
 =?utf-8?B?NTZneXR0S1pxNmhORXBpUFZGeVBEd1hhTzhEWTkxYk5JVmoxNGNiQUsvOERy?=
 =?utf-8?B?ZnJqbjFuVlMrNkY5WHlvNFlRNlBjYWxkZW85RkF0ZGY5c2h2ZTFoUWliN29J?=
 =?utf-8?B?R1hTTWxiZGFYdnQvR0hJV3VSS3poZEFqRUMvdTd4K2x1NVM0ZjYrYmIvWDdK?=
 =?utf-8?B?Nko0RzNBU1owamx3RW43V3pEYzRSdDB6Q2xrUzZQQmxYOWV5UXdaZjJOZHVY?=
 =?utf-8?B?UUE5aEVCcVByVkcwd1FTYW1MRk5UMW0yaDhrS3k5Vm9lcmVabHBQdCtlMi91?=
 =?utf-8?B?bkpyRmZWV3gxU0FlcFovRGM4aHlTK0txSXRpU05DcXUxQU1pSnZ4R1BodDVa?=
 =?utf-8?B?SXREbGhyQjJlQWh1SEpMYXVKQkM0enUyakFqWGpIMmdVWmlzZWRUbXg4Zk5h?=
 =?utf-8?B?RlBWZldPY3BkVGl3Y2tDdFdlaUZUaXVrNzdiWUV1eTc4eHR2SkhTMCswMXZM?=
 =?utf-8?B?U0hLNEpUZ3RWaC93VXNHbUFibFF3MTFvcWRrMUNoRkR0ZHg0OXptTlZIN0FQ?=
 =?utf-8?B?MFhWcUU0ZVVXRW10RGY3cHRZaVRZRTQrQkwvdVREeUsydzRyMmp6ZXZ5RXpH?=
 =?utf-8?B?eDVkckpRRmlZR1RNY0ZUNlk2Z0NWQy9nVHhKZU44RHRQcVBTWGh6cWh0SHIw?=
 =?utf-8?B?RVNZVWJzTDdFMlFEdDk3SkZudjQ0Q2I2a3F4MWdiWXVKUzdmaGZNUXJTSFNk?=
 =?utf-8?B?N01GVjFmUUJjVXA5dldiZjJ2MWJBUnNidTNUWTZweWpTU25FS0wvMUF0c1Rz?=
 =?utf-8?B?OGxENjhIL0hzdFFPU21jQitWcGV0MEdHZnZBT1ZWbXFaQzAxSUwwTGxpNWtZ?=
 =?utf-8?B?SU1FVG9mZVNBc1l3Z1NUTDlqYkpKRUc2VkVNNFN6SkM3bFFZdjQ0QTd0VDhu?=
 =?utf-8?B?QWI3KzJCcGp1REhsU0wxSmZFaElPYWQ0NkQydzVVZTR6SDRXSmZweEhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Y1VXRRRHhCeGR2aW5qUHJ2UG5TK0d1UlVxQ0VDYWkyRjdrc2lwRXc5ZDBn?=
 =?utf-8?B?UE1uRlZpbHpxNWFRTk5KYlg5T3lIM0NmVnMxZWVwKzUrQUUxckVLR1dBRHNp?=
 =?utf-8?B?UGFsL2JiRWZVSENTbjhQb09lTG5LNTlWbTdoTElFWEd2bGllQlNzT1ZaOVhB?=
 =?utf-8?B?NEhUN1FaMkovSWp5by9ldU1Ec0wycHVEOUcvRCtvTzBYN01CL0VCVGxEMGtx?=
 =?utf-8?B?WC9YYXlpUXZhTSswM3ovL2tTVmVaUTRLZ0F4cFFsRURTUmUxUXp1K0VYOWdG?=
 =?utf-8?B?cVd5MktIenRaNWlVMW52SUt2T2FWSGpJdU5EdUxWM1ZpcStKU1lRU0xUK2ZW?=
 =?utf-8?B?cFZJK1RSOWNEUFRKT0d2ZVpGcTFEUGZQSjBHNXlBM1pFem5mNUc2Ni8yRHFp?=
 =?utf-8?B?VWhSc3RubnB1V3hYVDRHMzJZNDI0bkdFK2xxN09pM2VKbTBRcVprSmRvK2lI?=
 =?utf-8?B?c2F5U0htU2FrNktOcnJDSXRMNE5oNG9ZdkJjeEN3dVUweDZURnUvNm52ZnUr?=
 =?utf-8?B?NWtXZUx4YWFWUU9rZUNvRGdoa1ZaZElyS3dRMWFVeXQ4S2lTaURyLytHV3o4?=
 =?utf-8?B?RXpCTlo5Y3JZQWNsUmpWSGZXbGI4L3RKVXhVemdIY1ZmZldZdjRtU3ZVTVJn?=
 =?utf-8?B?cE5aTGVJY0lRTTc4LzA2alZ1MlBzb0hxVk91a1RtRVF0MHdDTVlzU3Y5aXdQ?=
 =?utf-8?B?UzBzV1F2Q3llSTBOVE4rMzdDbjE3U2N1RHNvUTdlbFJac1ZFV0czeEpWMys5?=
 =?utf-8?B?ZXJDbUEwblBWYmdGcDlkejJDWWpERk5BSmhCMlZVUDdPNWZKQk1CUXpQNDRE?=
 =?utf-8?B?TGFqejhjeGdOWUJoMmE5Nzl1YnBKeExDZTlyMkMzSm1WNW5xcGZmTVBFLzQ2?=
 =?utf-8?B?Y1VQNUd2Rkl5RFZZMFpOQjBhVGpBcUNtaVZpeU1mZmt2NTU1d2RjUzVNTVhR?=
 =?utf-8?B?OEhIZHMyZ3o4NjRCVktUYkZ2S1VPdVFhK1NlZk1LQzJ1SXUwUm1RalFHR1kx?=
 =?utf-8?B?WTZrSE5ybjZPblQyQ2EydEtQdWpMYkJtbHZONUU1UUtqaXJjSEZKY2JlSi9O?=
 =?utf-8?B?NVNJanYyeEEzU3MraDJHamUwaUYzaEVHdXp5dmlHVTZsUXNabG5yeGlnTy9k?=
 =?utf-8?B?dDBWcmlaUWcwUVFINDllVzdsZ211VFdaRWptU1h2SXIwamNEUWZVSE9xVFgx?=
 =?utf-8?B?Vzg1c0tIaXBPWEkrbUdBY0E4UjI3Qm11c2UvWGo1Q3ZsK1hFdzJjL1pwUjND?=
 =?utf-8?B?a2pDYjN4ckVOVTBuWERrTmE4cTZRN3hJZHdsaHpWdEsxaWJjQXhCTHFzOXFu?=
 =?utf-8?B?VHJRQTk3Y2hEODZvWjBibFlHZFpVYlJtdGFUOGMyMlFnY1JVMEVNYllHYWdS?=
 =?utf-8?B?WmpDWVZTSWg0bFU2LzczSktLcmlDdnA2dTJZS2ZkMGxJc3JDV2FtVTcyQVB4?=
 =?utf-8?B?cHZxT0VOMldyU2lNemU2STI5NEphTk1ZT21ZWDVyeWtwVExzZTR3MjRNeU14?=
 =?utf-8?B?aTFRSlBVWnVOMFlLUzEyMk1OQjVCYXpyQVp4M1ZOL1FqUmJuQXJad1REQmg2?=
 =?utf-8?B?ZXFza2YxdXVBQlpKS2NwVndlUUNmS2NVSEI1QVRpaGdPYVJBRkc3ZFViSHpF?=
 =?utf-8?B?Y3p3S2JIQ2FBMzVzLytCdVcxOVRGSlkxdDNZa2huMkZCUHMwNjVlNGtMTU5W?=
 =?utf-8?B?dFJYazB0NzFCUDVyWWlHRUFiZ3lzUjdPRytlWW9qRFYrNEVsYTJYQzdXK2wz?=
 =?utf-8?B?SWpOc0xRV0pENUJNUVJGNDBMenNVeWI1a1h6N3Njc29ydms5Q3AyRWlZWHZs?=
 =?utf-8?B?L0FNY1JQcGFnNkNoSHYrRk8rcEZuK0VjeFhIMVUvMnZIVnlEUzZqaEY0YTFr?=
 =?utf-8?B?aGdjMmNJcm5TekFtQWROSUNMbUxwYXpIc3R3VS95ek5nRWFrSWYzUVdsUHRx?=
 =?utf-8?B?b2FYYWc5S2lrN1dYNHpxZnErNE9tRlFzVE1WbVd6MlQzd0c0US80bmc2bVFo?=
 =?utf-8?B?MVI3SzBsOWVDay9PaEdCaERUM3UvTFFVMk1ORWc3Q0ZFN3FvNWZ6VVMyT0VP?=
 =?utf-8?B?OWxkdFRacmJTVVEwcXQwTU1MOHpQOWp2bnpiekJVQTdKL3R3UXRkMFlOVnFJ?=
 =?utf-8?Q?0do2OKxiNMyQkZYx+uDZyFW05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11da9d6-1203-493f-81c1-08dce9067f1e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:35:29.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07Ecg/v6abQlSpmxGWro70KcFeTeCOHJkwZp5v//Fz6wrN+cHQ8D5FLr6Y9RerEISleJAsTWoyCBZXpiAIA0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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


On 10/10/2024 1:42 PM, Lazar, Lijo wrote:
>
> On 10/10/2024 1:13 PM, Christian König wrote:
>> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>>> Before making a function call to suspend, validate
>>> the function pointer like we do in sw_init.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>>    drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>>    drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>>    5 files changed, 46 insertions(+), 37 deletions(-)
>>>
> Original patch series is somehow missing in my inbox, hence posting it
> here.
>
> Below ones are SOC specific files where we know those blocks implement
> the suspend sequence. If they are taken out, then that needs to generate
> attention. But this check will cause a silent skip.

Hello Lijo,

I have not idea why the series has not reached you in first time.
Second i did not get your point clearly, I am just cleaning up code 
which just return 0 and doing nothing else. I guess those suspend/resume 
functions were expected to be implemented but right
now its empty and just an additional call in stack doing nothing and 
hence needed cleanup.

Regards
Sunil Khatri

>
> aldebaran.c
> sienna_cichlid.c
> smu_v13_0_10.c
>
> Thanks,
> Lijo
>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> index c1ff24335a0c..e55d680d95ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct
>>> amdgpu_device *adev)
>>>                      AMD_IP_BLOCK_TYPE_SDMA))
>>>                continue;
>>>    -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>> I think we should probably create a function for that code and error
>> message repeated a number of times. Same for the resume function.
>>
>> Apart from that the whole set looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>            }
>>>              adev->ip_blocks[i].status.hw = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 340141a74c12..51607ac8adb9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3471,12 +3471,14 @@ static int
>>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>                continue;
>>>              /* XXX handle errors */
>>> -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>            }
>>>              adev->ip_blocks[i].status.hw = false;
>>> @@ -3553,11 +3555,13 @@ static int
>>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>                continue;
>>>              /* XXX handle errors */
>>> -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +            }
>>>            }
>>>            adev->ip_blocks[i].status.hw = false;
>>>            /* handle putting the SMC in the appropriate state */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 3e2724590dbf..6bc75aa1c3b1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -40,11 +40,13 @@ static int
>>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>>                continue;
>>>              /* XXX handle errors */
>>> -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +            }
>>>            }
>>>            adev->ip_blocks[i].status.hw = false;
>>>        }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> index 475b7df3a908..10dece12509f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct
>>> amdgpu_device *adev)
>>>                      AMD_IP_BLOCK_TYPE_SDMA))
>>>                continue;
>>>    -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>            }
>>>            adev->ip_blocks[i].status.hw = false;
>>>        }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> index 5ea9090b5040..ab049f0b4d39 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct
>>> amdgpu_device *adev)
>>>                      AMD_IP_BLOCK_TYPE_MES))
>>>                continue;
>>>    -        r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r =
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>            }
>>>            adev->ip_blocks[i].status.hw = false;
>>>        }
