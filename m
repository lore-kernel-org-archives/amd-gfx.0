Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DACBC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D976810EA3D;
	Fri,  7 Feb 2025 07:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OwSUU/tP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC0210EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 07:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2CquUu7Q9AYu7i62Nd6WmS1/7xuuLXpwrpD2riYJEPw9cf7Vi5TahrxQpzgeNIw3fODXOM1kN0PYPr981ysE6XoA/0/69LQiwgiyWbB+vl7Gaj02iHbDZZEK/PAIUNi6K4eapdV58e+CClEGm35TTp5NdLBjcZ2Q3/vCf11ID0xgoHx1rYmS282No3XP0cVzLYsTk8EFJiYBwgeJNbqYs5OGhL/LJOjH4wxmnGRslMW6omnLAtbULlVNJitYyQDljTZXOoirikx7uK9s4oEA3RuErweZ3R6zV8Hpq2uc/WNAIGutPMlY7g9Pq+0Qx8fpl9kMqacYqe4EaYeDWX00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51kkIo0VHaBOxjW8nV0kxePNEbwDGKTzH4xAWFb2S0U=;
 b=q5qLcQVfqzohuTsYuSMgC0qgDd2zF/Gg2RxxNeBaT+UoYGe1sXcNzrHQlprSAE5B3u1O2Nmd25URWgBMpe97Z2Y3aLl3XQlq83SHNGdmEbhCyH5aukN87EFh5lHpm/bvTtyTE8ctjAvsTPiPtGH0RaPatXrxIuzk0m0BBVUmQQIvOn+2Z29r61rBFPKafgDY7yqBMyk13T82AWRwWhWOFfjWVDwaICaJjWppgma3/CKjzQXcd++kkCsx31MLpYj5HZ3ENqjJ+sIORcuN82WNeJqkHLqrBrFyp9ks9gshJsL5iGKjS23e4Kb8kGc+RtzzanPL38bo5kv/r8VZfL78cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51kkIo0VHaBOxjW8nV0kxePNEbwDGKTzH4xAWFb2S0U=;
 b=OwSUU/tPYcoJVr2zVEnOM9VdkxCw4WTSbE0fIeqVw1FnyTj0Q4WrQwEsNCm11Wll2Rbc97kpveY120+gJWG67XPLR1pYNes2gh2zJSRjmyQVBAOwtQ7D8cEexQHQ0QmqyPGI+tYQCQqaYyJSlJ6Jk5LC1EktFbw0L+chKtTLIJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 07:56:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 07:56:28 +0000
Message-ID: <15722654-c1b5-40a4-8934-f2fd353e2193@amd.com>
Date: Fri, 7 Feb 2025 13:26:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 1/4] drm/amdgpu: avoid buffer overflow attach in
 smu_sys_set_pp_table()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <5d77360ce88ec08ceb6cd9e9347001dc427dc1af.1738910203.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5d77360ce88ec08ceb6cd9e9347001dc427dc1af.1738910203.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7be828-18e7-4499-c582-08dd474ced30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckhzZHNFdlFkVEw4VVhKR1k0UUxPci9reEtjSGl5R2hUdUJDUEFmbnY5TCsx?=
 =?utf-8?B?R2tXWXZDTTk0NmdDdU5oUURobDM2RlB1bEpNVjZOSUhORGY3dndBcEV0VDd5?=
 =?utf-8?B?NFlBWlA5Y0N3VGIzWCtrNTNVeUNLRVlDSU03V0ZaQ092VGJaUGRSRDZMWjdZ?=
 =?utf-8?B?bkNyVE1ocDlCT2pqRlJMK2hnNnlESzFQSCsxeGNob3ZMZ0VFNEF0TDUxeXlr?=
 =?utf-8?B?WE54Y3liNUZtUlV2NGNNSjR3bmw0UXdtK0VHWDhrK3V6b2Fla3hlMTNKK2ph?=
 =?utf-8?B?VmtReWJ5S1NHQXJ0SjNoR2NnMi9STUZ6TGV5Z0lmYzNSSWtqMU9lVGpCYzky?=
 =?utf-8?B?aGlKZGNqeHhhdkJFRjV0bExURzRZTHBMbXRsQUpuNzZxL1NQTmhERHZkNkFS?=
 =?utf-8?B?U0RiNTF6V05mZml1cXZQb3NFRHlaNm1ocWdxSnhjVmNRK1MxK0ZqbWZ5QWo2?=
 =?utf-8?B?OGVPbS9VclU1cGZRaUhuaXNBVldHZDVKTm1MQ2JHVE50OVlxelM0V0pzYzV2?=
 =?utf-8?B?NldIa0NSaVRrQndrWmJhQjBXYUhGNVRHWUN3blRlenlaZ2JLcXpBN2REOUox?=
 =?utf-8?B?bnFHQVpZVG14S1dVeEYvZ05POUNUYjZUdmJWMURnYnpPTzA3SmgrQks4dmNJ?=
 =?utf-8?B?UU0zcEcycW1LUHovams3aUVzdXdqSjR4cGlNS2NHR0doOWVUdllYYzAxSXBM?=
 =?utf-8?B?VnkvcU8yS2NUbVNoaFh2SnkzUkQ5S2g1Mlk3dnZrUWR0NDZjWG8xb25tL1JS?=
 =?utf-8?B?ajR4MGJDdkwveG4xV3ZNakh0blh6cFU4Y0kyS1cvZXI2RGwwQXZkbzlmcjR6?=
 =?utf-8?B?dzVwdHZzUEloU0pNbHoyQ2pCUTNQWGN1WnBWQ0phdzF2SEV4RDlkemtuaFVv?=
 =?utf-8?B?U0Z3d21rdkJyU3Blenk3cXhETG9kYVJHaHRlWmhTNDRZdTBTSTQyV1RSaGVH?=
 =?utf-8?B?dnJVYlR0K0J5Q1BaNllUR2Z6SnBoZy91TUNJYjBNT0o5SjV0N1ZMS0pPZ1Zw?=
 =?utf-8?B?K3Fsb2J4ZWpGYllZbTV1ZUk3UE9lYURYLzIxbmYvZm5NMEJUeFArVVFPN1Fx?=
 =?utf-8?B?V0VVbFY1bVhycHFtV2RKeDNicktETUNYU3BpK2Erc284dEFFMEoydUJ2UVhi?=
 =?utf-8?B?ZXpBSVgzd0VBWS8xbE9XM0x4MVZMSHAzWEhUNnlnKzVpR1hKZzVIaWRUaXll?=
 =?utf-8?B?Ty9DeDh1VHBtbStmcXZiMFdCYXRJVEg2eGdYYlFpNHhWaHVNb0k2SnZ3RGxk?=
 =?utf-8?B?T2daYkVUYUtxQkhpMkx3UWFDWjhCRnVXSUFvUitwTjhGL0UyWHF6WHRSMlNp?=
 =?utf-8?B?SGtlVGs2S08rajlrUzE5SGZ6QXdaeGlOczJ6eTV3OFY3My9SWTJyeVdseW1M?=
 =?utf-8?B?M01xNGZPOExqaWhENENYNE9VNDJXYUNKTVBQZ1pSL0F0cHV5OHl2MWtudHNT?=
 =?utf-8?B?akMxeHNwMExOWHJVR3AwTkJVNjFhUGpjcWY0bjlKbjRsdU1VaGYwWlBsdFpY?=
 =?utf-8?B?NUI0RE5GOGtMNE0raThSV0tEb3JHK29jNU5wZVljUk9aTWJ3eXB6L2FmMEVJ?=
 =?utf-8?B?ampQeDJNYmhJU3JCNGpRWHlrUnJFZEpmbmFIbEtWSythMGJHZ3RXSGVlSHR6?=
 =?utf-8?B?b3NERjZZTTJ0T2tDRDBnUjZ5ZllxcVB1SHV5eEhiYTErNHowT3lsMnF6ODhu?=
 =?utf-8?B?SFRvSVd1Z0JmUEFKYlFKT2dDYjhaZzIzOFhJWGhtVlRLdDN0TnV2QUdleG4r?=
 =?utf-8?B?Y0dLNlJwTndGeGlpRStmS3BkTjJ6WlZQU0pXd2ViUmNUOGpzdW02Rk51N3Fp?=
 =?utf-8?B?RVRUNk4zNnFVbEt4NzdmYkMzVjcyeEQ4Z2RoQVY0ZCs3NytyRTZUZEFIV1NX?=
 =?utf-8?B?dlc1ZkQ1WTRmZ2ZFejhuVHhlOXhUUlgxUjBRcCtKY1poTFM0M3JWQkZ2bkN4?=
 =?utf-8?Q?zzrVNMjPe8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFHb2QvVU1Hakc0ZVIxcGhscU9HZkp4M3ZnM0d3SFYrZnU2a2RvT0lWbVVN?=
 =?utf-8?B?Y3FzaUVqTzhaZk00ejhRTFVVQmRCQkNDOThTTWsxR1BKdnh6ckF5VldUWGNl?=
 =?utf-8?B?YUdpWkd2bjJGaHZEVlphOTBEY2tjQWVnbUgyOFo1Ymwrdm52ZjlMcG9CenVy?=
 =?utf-8?B?QS9COFhRdEJMSTVxNTFaZVFuMmJRbkdiQjJaUjBpMEpROXRaMGw2RW1PN0tG?=
 =?utf-8?B?NnpvWGtrM2xHWkd5b1NGVkhwT2pRYzdCcGUvNUFKYXZvTVR1NDBYRHJIWm5Y?=
 =?utf-8?B?VWJSMG1GOFA4OTZla1hydisxNjh6eG9SVnd2ZVJBUXlzOWFJWXkyemNOam4w?=
 =?utf-8?B?NXoraHhGRW8wRFVRMCtmQVd3bG9EYWlFU0k4bWdSTWN6b29PYTEzWDFVQjJn?=
 =?utf-8?B?UHp2OHNiUnNxalg3dlZ5R1BOMTluM2NRTnhBaUZSbkFXbkVvQzBqM3pMKzBN?=
 =?utf-8?B?enVYOHJvVWhXanFGR2dnaytQeUxNUzQrYWovcmt1ak5CSzlwOUJYUHlqUVRG?=
 =?utf-8?B?Y2U1SWpCem5kSHBITmkwTEZxbUFnbFF6YzBlUk05RllYTHdNdlBjRVJTa1Rl?=
 =?utf-8?B?N1ZsOGhYWFJhN2hzN2wrdURqYWRlUDJPRXowS2txVUxyNWZGVzVoellmTmFR?=
 =?utf-8?B?WGF1d0ZrUXkwcU85TXdJdFhIYmozMlhwbEppS0tXSEZjMEJIUnBtaFl2aDJh?=
 =?utf-8?B?RWhFcHcxRjFNTkgzNmFnV2I2RWhpdEVpdEw1L09sK01uUXAzR3ViNUVtMVFp?=
 =?utf-8?B?OTZsZXlQa3puMkJ4SGhCQ3lFWmlKMnB1ell1Mjd2Q2E1aTVnbTBEM0FTbk9U?=
 =?utf-8?B?MnF2S3ZtbEhKTjQ1VkIydFAvczl6QkxoL1V4OEs5dTNhYjRRckJzSUp1TGpY?=
 =?utf-8?B?YjZSR3B3cUVxdkQ5d2ZIaUhYRXo5eEx5dWZCNDlSQ2hvVXR6dEpOc0xSRzda?=
 =?utf-8?B?YzdRTEFiMUZqNnBTM1k4R05Pa1ZaeDRvQ2ZqSER2YnZkaW1ZSXZxeVJDOHV5?=
 =?utf-8?B?UHNmVFhxNTIzNjB4Qzk1QlBXUEZxOWhRc2RtVjkvS0tmVHB3VW5FakVkMFhx?=
 =?utf-8?B?ZndXZWRrQlNXb3NDOWNBSEN4UTNIaVl1YXZQazVtajFaQnVMUURXVUlzdldv?=
 =?utf-8?B?aHozMzR6WkJiOXhWNUtTNmxTTHhvTXVybUtrbkYyOUZoVXJPTmVkQlA3L29j?=
 =?utf-8?B?QTkzMFJ5dmpIOXMxZXFtRUtUMU9LODlxbEZTUWpNczZTU0Q5WXp3K3ljZVdi?=
 =?utf-8?B?MUpVS28wV041ZWl3WkFkbys3a0FianI1KzAxbEpUT3ZiYjdNeTlBYk53N2lp?=
 =?utf-8?B?OUlzd1NtR3RiRENoYjlkc1VxNHNXZkgvd0tlSERKa2V1OTZIUG9sZHdYV3NZ?=
 =?utf-8?B?dm50RVBiR2Y2RUJlQmN3TEhvUzlLcVlJTGhOQW1QWDJzOXhybi9tTnA1WEZt?=
 =?utf-8?B?MVZ2TU5hWDQ2bXZKQjRHWGJCbFdzaWlneTB5Z2YxN2VpdU1KdlJiczA5VHpH?=
 =?utf-8?B?WkdPcGVBaVV0QThEQ24yUnlkT0lITVhWUUE5dUVRemljZGNrTTNob00zdE5K?=
 =?utf-8?B?UVZQbDM2TTVCU2NEWFZhU2E3T3U2OTI3Tmp2eFMwUFo3cTRUbnA4eVNGZm5B?=
 =?utf-8?B?bEo3YkhlbDV3TDh5Z2g1VWdNQjErVHMxVlNjSGFoNVhiREF5SWh2VENreUdo?=
 =?utf-8?B?cVRFNUsrcUVlY2hZMUxhemorQ0IzWVErQmhMOHA4WjNMRTJLZlRRZ0lSTE4v?=
 =?utf-8?B?M0tlRHljK0YwWDR3bFFNdjJabDJzMCtZaWFSTkFONEsrVXc3dFNXaE1Ua0xD?=
 =?utf-8?B?MWlWeTBuY1F6QWVJTFVETjVnTFRCK2l1ZTJhUThSZFRXS0NqR1F6NzRaTVVR?=
 =?utf-8?B?Q3V2SEx6b0pNVnpEbDFLZ2pkMi9yRE5aM0ZnNksyRTZGUDRsRDhlT0lDVGRr?=
 =?utf-8?B?T1UyT1UyNUJNK0h6bGttWHhBMjNmOTd2bWlvaWY4aEhjNFNJdGd6aFN5dXNy?=
 =?utf-8?B?ODl3SDc0K1J2Y1pqRWdCdmZUK0tCOWFSRGtjS0lyc2EvbkFvQUVxb0x1eWNO?=
 =?utf-8?B?cklBZzQ2VU1YMURDQmVDYTNLOW82QVpoMEZWZ3ZjMy9jWU5VR05LRDdyTDRR?=
 =?utf-8?Q?RdL89dG8yr5UwQQ0F7MOSTqbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7be828-18e7-4499-c582-08dd474ced30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 07:56:28.2727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGlqUGTDaogct/EDogaSsdmHuSPXveLQcNL8T+Ti21D0EHgsywBpW9VCxjdQsCLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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



On 2/7/2025 12:14 PM, Jiang Liu wrote:
> It malicious user provides a small pptable through sysfs and then
> a bigger pptable, it may cause buffer overflow attack in function
> smu_sys_set_pp_table().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..ed9dac00ebfb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -612,7 +612,8 @@ static int smu_sys_set_pp_table(void *handle,
>  		return -EIO;
>  	}
>  
> -	if (!smu_table->hardcode_pptable) {
> +	if (!smu_table->hardcode_pptable || smu_table->power_play_table_size < size) {
> +		kfree(smu_table->hardcode_pptable);
>  		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
>  		if (!smu_table->hardcode_pptable)
>  			return -ENOMEM;

