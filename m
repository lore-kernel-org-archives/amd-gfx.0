Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9657FCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 09:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0246210E60F;
	Tue,  2 Sep 2025 09:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ra2hyGt5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5737810E60D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 09:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaaWIhfm37EB0UgJtiuNCOlMe8acyevo4OK6MnqeznDwysITTxtepIZsSkUMkZuOhYxXUagg3LSlOcN5MqxpB+kKy4xUL0s+emp3qeBdczytQgUL6/msd6iwds2lPSpKn4QJjvJJ6kT4anJVc2wVfy0yhyVOksn26pgZP2DJtaY8oOLuj0Abr+15NmT8RbUzMpRZijRFb+6fRoex7sxTq38sZtjkNm5tawSsmyNPpNIMbwgKt5daS7O1tAITIp1RcBydayJebe8VVsQuosHJGYOS3/mxGb4O85740SgxeVlFocYrtB+iUnxwGGeTXKi7OExUlwaPIqSx+ST2kPjyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YhzcenPxLxdcN5l3a7PEi9b6MbJvaH3clO2tq2Jj2s=;
 b=w4+OhEOYwPjgYI0S3NrPfkIP1AZ6NX/cBMfMKZpSmSrjxb4/W95NrunJ+gKeZXlH1c+PZb0zymNNITFZMdaCsmVtLhao2SsWc9gZzllKLJYgKB0WR6E9LiFMWfsf/txZvrvPF8OsTPNxmau7Wtk4rl23jf5tph+bi6eExX9iP9gIgN9b43G9OsXuy6jqYqw7W0HU5/bQgURYsTdM8mkztOxSs7Ttv1OZC33xRF2gdQb7NKZa9+itw6HVUsuMQGKXahihlcc081CC81cK1ld+5xv+ysGyE864KfQVkZyy4P7iJyL2xt1oUsgUY4LcOIM1CiZ4hpDHql5AdxMlhp7BBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YhzcenPxLxdcN5l3a7PEi9b6MbJvaH3clO2tq2Jj2s=;
 b=Ra2hyGt5zNlRjITJURMEpAK9nn2jbhI6DgOabQaN3e8CAQQ2kSTOSCiIfWmyp5PUEULZUjFmUWvPXjLPOeG+5iru2VwgxGujLg8T6bwrZ2Vbixwl18JqgZNMnhMOsEfkWeOHjyD75dR4GbxUiXmyWvY2vXr5xcQ334gI69qSAdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 09:07:43 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 09:07:42 +0000
Message-ID: <4149e06a-da7f-46d9-b8da-f0aacaf75758@amd.com>
Date: Tue, 2 Sep 2025 14:37:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status
 lock" v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <20250828150200.4035-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250828150200.4035-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0074.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: e7efc3c8-a24f-4e15-6868-08ddea002c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmtLWmpTNXhsbTdRdWJFT1gzV0JBdmJhWGpFNVNsY0hFQWRDQ3BDd0o5L3FM?=
 =?utf-8?B?Mitpc1BoWE0vcHlvU1hwR245L3pLYVFlbm5jWWt4VGhScmJUZjBLUS80Q3A0?=
 =?utf-8?B?SEZkWTkxU1JtODJIdEtoa21yQVVPbURqckltaUpna3pYYVhTbk1YS0JaV2cw?=
 =?utf-8?B?QVRDM3VJeDVNRnJUaGppbWVHYk9XUnhkZUlBUVpDWUppTmxsNkg2MG5KQkY4?=
 =?utf-8?B?MnMvT1FCREFIZUdnSTVVTHppODZzRlFHRkx1Szd0dGYvSDBTUkh1Q2VoU2xw?=
 =?utf-8?B?aTArL3FpdldDVDFCT0k1c2lxbFU3S3F2VDhPQ1VCaE9ZNEx1WXRlU3huZjk1?=
 =?utf-8?B?WlhmblMwZVhzUjZiYVQrQTVYM05OUjcyRkhEVFJ5TTlEL1NvbUlIaWp0QTEy?=
 =?utf-8?B?UFpsMkpMeWhIMEoxR2JwakF2YVA1a0ZjdU9BbWpBT0R0eVBEZEFVdWZNekJF?=
 =?utf-8?B?SldZalg0RldIM3dQaTExcGZBKzBqbkhPbXpFbmozY2RtVUVoQng1RWY5OS9l?=
 =?utf-8?B?TjIvNUpwYXJhaTdzcWd3anR0Q2w3aXpuZDI0b0FRZzhQeXpxQmczU01ZNjRW?=
 =?utf-8?B?T2M5TFZrQU92M283d0EvR0FoeEtSUDFUN2o2RUo3OGdxY1JZS012WHQ1aW5z?=
 =?utf-8?B?STlFb3NWM0NwZENESzZMS1NOSEJrakhFeGVlM2UxRFB6Ly9MVS9jT25Wa0FO?=
 =?utf-8?B?UFM1MWYreFM0dnVwMFhpcnNHaEZtVVp2VnZUTU4rdE11SVdMcjlQNy9waHZN?=
 =?utf-8?B?aDJ2bExyaEpYbkxtY1VIb2dwNHpVRmxDK0djaXJXbTk3dFFGTTFUY3pTTjhY?=
 =?utf-8?B?dzY2MjYzcDN0SENoUmVjMEs0RnYyWUlmZ1RMVi83R1ZyMFAwMFBmVEdDUmFy?=
 =?utf-8?B?cEszZEYwWjFDSjF4eTBGQ1hhZVREdHVHeFpiQzRTSVZzN0JyczZnTFBQYUxm?=
 =?utf-8?B?aWdCRVlHTXN2V0lSSXFIYzZQQkxFT1dpSlAxbk5nTlNXclFaL2drYW1iWUs4?=
 =?utf-8?B?M0l0WTZFVUlCeGF3c0orU0tBYmN1V2RoSXk1Uk1LQXdRS0VYR0I0L0ZNWmZI?=
 =?utf-8?B?ck5UQnZxQWFGNzhTUGRoK1o4VzkzV3BmN09kYXcrNkZJVG15MXB1RHBOT015?=
 =?utf-8?B?UFc1dkMzeWdlVWZ6WU1vSnFGVCtlZVc2ZnB4NXRDUTRmVFZId2c1dklxSnor?=
 =?utf-8?B?ZmZXcWNJZ0RnL245REU5ak9xb3Exb1VPY1ZpQit1M3dTdXZyWVIxSnRtY3Nt?=
 =?utf-8?B?UnR3akpQWXpwZHhNUDlQK2kvcEFlY0JhOFcyWFAzUUl5NFdIMm1aOU5MRXMy?=
 =?utf-8?B?SXFBbFJGSEdxbi9Ody9KTUhTZVJnUXZ4YmFobFUwa3AwK2duNW15NlJlUkkz?=
 =?utf-8?B?ejF4eVpaZ25GWVFFYWJkM2RrcDRVUVdJWmNBNktwTi8wKzl2dFF0Q0tORDhO?=
 =?utf-8?B?ZG5xaFdheVZlTWZUUWdjRUhLdUQvVVpDcE51QW9SN1praWF6MnVBdjUvY1Z2?=
 =?utf-8?B?QlJ2bmUrbisvNnBDTDNHTmlxUEdaVUhyZDBtZXpzcGRvSmkzVS9sZ083RHJP?=
 =?utf-8?B?YnVTZTZnMkwvYS9TNzZxaVczWGNKVG5tdFZKSzNLaWZZL0hlaEliVnFmN1Bi?=
 =?utf-8?B?WTd4R29oN1dhOWFMS2lCaXJBeHRYRzZIVUhSbExkQVBZaWpyY1FTQlo4bGxE?=
 =?utf-8?B?MWVQQ29SQlNwNWZZNENmN0l0NVN3KzN0OFQ5ZDdSRVVsdFdTM1ZpL2p5eG1r?=
 =?utf-8?B?aDFnOXJmakdXZXVCWS9ZaEFibHdCWkpML3FIaVdkOVVjS2xaMm5DVjBqN0dB?=
 =?utf-8?B?Skx1QWtnODRJVzYwSmNLTFZpeXd0TUFsMDUyUUx0bkFQb0N3bDBtcmVwM212?=
 =?utf-8?B?YVl5UURhdEljQWppemhCQlRiMXIvbG5QMXMxU1UreWVzN1lxdWZleVdISUgx?=
 =?utf-8?Q?oBeLqYK5WSw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FXNnJkRVZyTFk3VkdGZ1N6NHVMc1h6d3hCRDVqc0ZsWjJsd2VMTEd0MEQ2?=
 =?utf-8?B?Y1AwWlBlMThwSGwyY0dFc1NSWmE1MFpOaGVWRXZ4SHR0Z2c0VzJCYkkwNHFY?=
 =?utf-8?B?SnBMeXF6RDkxOUowVUkvVzdEK2RKdGU5QjZDRG42ZkxSQmM5ZEs3akVkZ1BR?=
 =?utf-8?B?aE1BaDdoRTlSWWRNWWZETUdpNzlBb1lsd0FkUjdrV0RGV0paMEYrZXZFUkN2?=
 =?utf-8?B?dGZVT2E2NnhhbWI3NUZOdkk5VzRRaFZtNGI4Y1AzZ2RadG0xcy9tNkZWZkk3?=
 =?utf-8?B?R2ZRT2h6d0JQQlY3QUtSK0dDT3IyTzRFOGQ3ZGorQlQxZEFEdWkyRXRVOXFX?=
 =?utf-8?B?Y2RYcFhiSUx5cGVDZmE5MXRZeW9nSVp4WG9GMFpRRnJ6ZkJUenQ1WDZsZVlQ?=
 =?utf-8?B?SnJpcnpHRzBidG1EdFBiZGwvL2V1bmJpMThYRlRWMW13amtvcWVVVmhWcjdF?=
 =?utf-8?B?eThrc1gvU0FPWVBmR0M3YXZIMDlJQUNhYVU2RlExU2RURXB6WTBZa1hvZFB6?=
 =?utf-8?B?R3dzWVJ2aEtPRHRsU1RqZzVRZUpjUitpWjV6NE5wSGQ4a1pLNTRwVG8yVjkr?=
 =?utf-8?B?S0U1cWk4cm5sRkdKSE56WUkrdUVCQWtWMVozaEhXUTk0emVlRzBMaWpRcTZG?=
 =?utf-8?B?R2JLQXVMR1dlYm1oaklLZnFPcmcyWitiRzdONVYwMVRYRkUzMTZSeGlpK0lZ?=
 =?utf-8?B?Sm93SUV3OE9BTjBMTVZiV0NoOVNVc0dwOU9qeGhlQnBVdkZJd3piUFh1bmNT?=
 =?utf-8?B?dDZuaS96U0UxMG9FTEJidnh2dmRPVFBNUEQ3b1dnd1hkUDRGVUw3VFlUWDRl?=
 =?utf-8?B?UXJLK3lJWGEwdWVNVXJkQ1NEZHovVndIdmlHY2FXaDcyQWZGTlcrUXovUE1x?=
 =?utf-8?B?eGdOMm1uUkhOSG44b2QycEJNNjFmMXlGTnpBcFpPTm1ZLzJjei9adTNKYUt4?=
 =?utf-8?B?SGhmSWljNGtLVnY2MlRlVEVzN0Jvc0hHVlFWOWhIT0JxTzJ1ZlJvR2prMzJy?=
 =?utf-8?B?NVFxUmU1QU1yQTNhRmdSYUJZbjJlbXNKK04yWjlCQVJsSXkrRWhwT1VXcFA2?=
 =?utf-8?B?YlpqeFA1VGp4ZEZsYldwbDNqbWFGZHZmUW92VkM0R1JBdXJZanl3R0lCRHU3?=
 =?utf-8?B?Wkczdkp4SXBpUU56ZmNPeFBPeFlNWDE4MndMMk1yVkVFOGpUcnhYTjIvdUZX?=
 =?utf-8?B?MGlQbHhsWWUwWjdIVm53NjNZV000STB0djl2VmtWOURiV1lwMWI0R3VCclhw?=
 =?utf-8?B?elh6RVB5akpldzZGYU1CV3JSaW0xSkJlbUExZEg0aGZrZmRHZ3RINEVJZHhh?=
 =?utf-8?B?ZHZRUFFGdUdHM3RZWmx4NE12UkE3dy9PVm4yb0gybSszU2NFZmN6VklaYjNK?=
 =?utf-8?B?S1o1WXgzWVI2TWdxZ0tNSDZER3NhZ1dwSVAzZWhNOWU4ajhVMmtIZHU3VURK?=
 =?utf-8?B?OTVPMGNVRzE1OUVxR0IyU1NsNVRHL0s3d3I2UWwrSWpnenBQLzlnOG5Gd1Vl?=
 =?utf-8?B?b29wckl6cW9HZ2FNa0M4NFJDem1FeFFYWXdIRHRNTWhGb0I2YlJJUGlIblJz?=
 =?utf-8?B?OTgrNko4cEluT2RiaU5Eazlrc20rWEtubDc1RGVtMmRSMmdiSCsvcjkvQUFJ?=
 =?utf-8?B?RlBGWFRGK1o2Q1pvUHM4ZlNuRU1GWjhpUHNTbDFUVDY4UHUraG9BTEUrMjlz?=
 =?utf-8?B?bE1JZ3JubkNOSGQrV1JiMzFsbzZ3d25YSUVJdHA4c3FYcGhrNlJLRG9LVGEy?=
 =?utf-8?B?NmtiQ1VtOGVXU3lxQkF4czdMamtFdXVTOEhBejdWejZML0FseDhmVU1zTFM0?=
 =?utf-8?B?Mm9uak55bVFVV2dWbmNKYzFPRHJWRmFsdEtEMUxWSk1BZzVLM1llaUlUR2hp?=
 =?utf-8?B?OFpLVnFzd2hXdTVadlN1NWEwUHdvTVJvUlViZDMzMEduNjlVQUp2MExFZ2NQ?=
 =?utf-8?B?TVRXQTJtbWo0elpuOENqRDhiZGpTTklaWGFlVjRNRnJPRlhoazNxV0s2R0oz?=
 =?utf-8?B?OHFCY09oMnpoSy9hYVREVkE1YldvZTUvVEVzZlQwelYwTHV1TzRmZVBWeG53?=
 =?utf-8?B?YUJTRjd5TmdHZ3YrbzZXWmVRbkRza0ppSEtVaktwZkpFMEl3d3lTOG5JL0F6?=
 =?utf-8?Q?6Q48IEzbgpoEG9y7GU6cbgefn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7efc3c8-a24f-4e15-6868-08ddea002c79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:07:42.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K4WrzJi98qEBByr7Bc9NjrEE1/GkE6yypCgER4Ii1KtEAuHxkA1LS4QOWanwCAcMrwm0P25ueap6xpsuFl85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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


On 8/28/2025 8:32 PM, Christian König wrote:
> This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.
>
> It turned out that protecting the status of each bo_va only with a
> spinlock was just hiding problems instead of solving them.
>
> Revert the whole approach, add a separate stats_lock and lockdep
> assertions that the correct reservation lock is held all over the place.
>
> While at it also re-order fields in the VM structure and try to improve
> the documentation a bit.
>
> v2: re-add missing check
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>   4 files changed, 96 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index abc2f96bea76..727dd2e27885 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -562,12 +562,12 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -584,9 +584,9 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a0339187eccd..a25134790476 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>   	struct dma_fence_cb cb;
>   };
>   
> +/**
> + * amdgpu_vm_assert_locked - check if VM is correctly locked
> + * @vm: the VM which schould be tested
> + *
> + * Asserts that the VM root PD is locked.
> + */
> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
> +{
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +}
> +

So the caller is now responsible to make sure to hold the root bo locked 
while performing all the operations on vm ?

Regards
Sunil

>   /**
>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>    *
> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	int r;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (vm->pasid == pasid)
>   		return 0;
>   
> @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   	struct amdgpu_bo *bo = vm_bo->bo;
>   
>   	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
>   	if (bo->tbo.type == ttm_bo_type_kernel)
>   		list_move(&vm_bo->vm_status, &vm->evicted);
>   	else
>   		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   /**
>    * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   	vm_bo->moved = false;
>   }
>   
> @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	spin_lock(&vm_bo->vm->invalidated_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	spin_unlock(&vm_bo->vm->invalidated_lock);
>   }
>   
>   /**
> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>   {
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
> +	if (vm_bo->bo->parent)
>   		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> +	else
>   		amdgpu_vm_bo_idle(vm_bo);
> -	}
>   }
>   
>   /**
> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_vm_bo_base *vm_bo, *tmp;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_splice_init(&vm->done, &vm->invalidated);
>   	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>   		vm_bo->moved = true;
> +	spin_unlock(&vm->invalidated_lock);
> +
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>   		struct amdgpu_bo *bo = vm_bo->bo;
>   
> @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   		else if (bo->parent)
>   			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>   	}
> -	spin_unlock(&vm->status_lock);
>   }
>   
>   /**
>    * amdgpu_vm_update_shared - helper to update shared memory stat
>    * @base: base structure for tracking BO usage in a VM
>    *
> - * Takes the vm status_lock and updates the shared memory stat. If the basic
> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>    * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>    * as well.
>    */
> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>   	bool shared;
>   
> -	spin_lock(&vm->status_lock);
> +	dma_resv_assert_held(bo->tbo.base.resv);
> +	spin_lock(&vm->stats_lock);
>   	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	if (base->shared != shared) {
>   		base->shared = shared;
> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   			vm->stats[bo_memtype].drm.private += size;
>   		}
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>    *        be bo->tbo.resource
>    * @sign: if we should add (+1) or subtract (-1) from the stat
>    *
> - * Caller need to have the vm status_lock held. Useful for when multiple update
> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>    * need to happen at the same time.
>    */
>   static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
> -			    struct ttm_resource *res, int sign)
> +					  struct ttm_resource *res, int sign)
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   	struct amdgpu_bo *bo = base->bo;
> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>   		 */
>   		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>   			vm->stats[res_memtype].drm.purgeable += size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>   			vm->stats[bo_memtype].evicted += size;
>   	}
>   }
> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	amdgpu_vm_update_stats_locked(base, res, sign);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_is_head(prev->next, &vm->done)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>   			if (unlikely(ret))
>   				return ret;
>   		}
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base = list_first_entry(&vm->evicted,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>   		bo = bo_base->bo;
>   
>   		r = validate(param, bo);
> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>   			amdgpu_vm_bo_relocated(bo_base);
>   		}
> -		spin_lock(&vm->status_lock);
>   	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base = list_first_entry(&vm->evicted_user,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
>   
> -		bo = bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
> -
> -		r = validate(param, bo);
> -		if (r)
> -			return r;
> +	if (ticket) {
> +		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +					 vm_status) {
> +			bo = bo_base->bo;
> +			dma_resv_assert_held(bo->tbo.base.resv);
>   
> -		amdgpu_vm_bo_invalidated(bo_base);
> +			r = validate(param, bo);
> +			if (r)
> +				return r;
>   
> -		spin_lock(&vm->status_lock);
> +			amdgpu_vm_bo_invalidated(bo_base);
> +		}
>   	}
> -	spin_unlock(&vm->status_lock);
>   
>   	amdgpu_vm_eviction_lock(vm);
>   	vm->evicting = false;
> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   {
>   	bool ret;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	amdgpu_vm_eviction_lock(vm);
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	ret &= list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *tmp;
>   	bool flush_tlb_needed = false;
> -	LIST_HEAD(relocated);
>   	int r, idx;
>   
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->relocated, &relocated);
> -	spin_unlock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&relocated))
> +	if (list_empty(&vm->relocated))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->relocated, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	while (!list_empty(&relocated)) {
> -		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>   		amdgpu_vm_bo_idle(entry);
>   	}
>   
> @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			   struct amdgpu_vm *vm,
>   			   struct ww_acquire_ctx *ticket)
>   {
> -	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo_va *bo_va, *tmp;
>   	struct dma_resv *resv;
>   	bool clear, unlock;
>   	int r;
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
> -		spin_lock(&vm->status_lock);
>   	}
>   
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>   					 base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>   			amdgpu_vm_bo_evicted_user(&bo_va->base);
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->stats_lock);
>   		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>   		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->stats_lock);
>   	}
>   
>   	amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2582,11 +2571,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	INIT_LIST_HEAD(&vm->relocated);
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
> +	spin_lock_init(&vm->invalidated_lock);
>   	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
>   	if (r)
> @@ -3051,7 +3041,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	unsigned int total_done_objs = 0;
>   	unsigned int id = 0;
>   
> -	spin_lock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
> +
>   	seq_puts(m, "\tIdle BOs:\n");
>   	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>   		if (!bo_va->base.bo)
> @@ -3089,11 +3080,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	id = 0;
>   
>   	seq_puts(m, "\tInvalidated BOs:\n");
> +	spin_lock(&vm->invalidated_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
>   	}
> +	spin_unlock(&vm->invalidated_lock);
>   	total_invalidated_objs = id;
>   	id = 0;
>   
> @@ -3103,7 +3096,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 0e3884dfdb6d..96d9b8947409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>   	/* protected by bo being reserved */
>   	struct amdgpu_vm_bo_base	*next;
>   
> -	/* protected by vm status_lock */
> +	/* protected by vm reservation and status_lock */
>   	struct list_head		vm_status;
>   
>   	/* if the bo is counted as shared in mem stats
> -	 * protected by vm status_lock */
> +	 * protected by vm BO being reserved */
>   	bool				shared;
>   
>   	/* protected by the BO being reserved */
> @@ -344,18 +344,13 @@ struct amdgpu_vm {
>   	bool			evicting;
>   	unsigned int		saved_flags;
>   
> -	/* Lock to protect vm_bo add/del/move on all lists of vm */
> -	spinlock_t		status_lock;
> -
> -	/* Memory statistics for this vm, protected by status_lock */
> +	/* Memory statistics for this vm, protected by stats_lock */
> +	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
>   	/* Per-VM and PT BOs who needs a validation */
>   	struct list_head	evicted;
>   
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
>   	/* PT BOs which relocated and their parent need an update */
>   	struct list_head	relocated;
>   
> @@ -365,15 +360,19 @@ struct amdgpu_vm {
>   	/* All BOs of this VM not currently in the state machine */
>   	struct list_head	idle;
>   
> -	/* regular invalidated BOs, but not yet updated in the PT */
> +	/* Regular BOs for KFD queues that need a validation */
> +	struct list_head	evicted_user;
> +
> +	/* Regular invalidated BOs, need to be validated and updated in the PT */
> +	spinlock_t		invalidated_lock;
>   	struct list_head	invalidated;
>   
> +	/* Regular BOs which are validated and location has been updated in the PTs */
> +	struct list_head        done;
> +
>   	/* BO mappings freed, but not yet updated in the PT */
>   	struct list_head	freed;
>   
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> -
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f57c48b74274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	entry->bo->vm_bo = NULL;
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
> -	spin_lock(&entry->vm->status_lock);
>   	list_del(&entry->vm_status);
> -	spin_unlock(&entry->vm->status_lock);
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   	struct amdgpu_vm_pt_cursor seek;
>   	struct amdgpu_vm_bo_base *entry;
>   
> -	spin_lock(&params->vm->status_lock);
>   	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>   		if (entry && entry->bo)
>   			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   
>   	/* enter start node now */
>   	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> -	spin_unlock(&params->vm->status_lock);
>   }
>   
>   /**
