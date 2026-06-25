Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AD4CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 10:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC8110F239;
	Thu, 25 Jun 2026 10:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qm4hX5z2";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA4E10F239
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 10:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg7hjnLhrH6U4qcJlzWn3qqwCaHqpbNMBa7KKuVTb6DDUppHblx9y9LEtfXm6Sop2FLoUOC5pQeqx9NFO9qfjBqQPrTv5YHEAkm5x10uX3iDE337UlRUu8O+vVW6qn4SvQ64Mfa3bfXwSp+VKiSv3E1DYtcNb0dQ4VT9ZWT0VKRyFSVTGxgajwUEEHiMNMNTwB/koMwlujGomEkzKu0Ug0TY/PsU7GrLkTMhs2txj0GBWZUoYXlD9SC+y/z5XlMDA/hBFRpM/S+xISpSk5MOFaEjNJjbu7GnTZXZdVL6I2nl+17azuWh21rVgmlRUwd4BEH8L5Xn1AZqGKhanorcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6818C1gHD2XaUZZ9nPGPu8ob9guOnyP+axEulx12Uo=;
 b=Bjbz/OhN6BTFYnWpMV/1geebYKil+YAN7MD5CnhPgqdQkGy2lr9Gol8w6tjn70J2IbCb1FFi8Y4iQdN6uUOf8aF/U3KQY6X3DYlf86saATbFw3mPUDRAZkKcWq82oLTNTh7ZVUKEjBSfV+GphJdWCpCSunO6oA0WacysmIkz0iWMZZRWdnZaPzca9rPlVI98Q9dYob+INN3htvqY09ofpLBKAiZmjvlwRt5PFcAOKAuh6xypbb68BugYA/NFh8psAhp8KvPxJ0/VBwmtihKwS5ZhG1PNbaHwza0Jm9JqbxaUJkImEuoZ3oMiTw8swvduulaTK51lylOKmYcyn1wSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6818C1gHD2XaUZZ9nPGPu8ob9guOnyP+axEulx12Uo=;
 b=qm4hX5z2zPatp0WuJuJ5hy+rYrksusU9QQSgFZx4xaQYV985wf8MFWWQX3GMYE83ObnyZ/gx6cEoW/C/i7OAvdufSOYKjNyuSYN3UQsRfo5CQJCb87Vv1d+sikWubjwZlcnw9r58dWvVErYfWRTNsk6hWTzXeXAEy6BHN2796uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:36:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:36:04 +0000
Message-ID: <453368f9-e877-4f8f-ade9-499c6b17d8b7@amd.com>
Date: Thu, 25 Jun 2026 12:36:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] refactor monolithic amdgpu.h
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260624175554.489406-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260624175554.489406-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:32b::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6e9a1c-7c26-4b33-5869-08ded2a58f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rOtWMdqPNtpM2ClBHfSwayjsW/Dq3TyCxF92B2AAQheaJZSsKhhB5iZ6OKTQVheQqtGlAdnwvG8D3YaZZLFGjaWd3EsR03esuPW+ySSqDOigbk4gXTqMyqNn4hxBzcPDATVkixtBKL001QqLffQL7+1ZN5MTtmWIZTvz8rzxSvYWlYD3JB22Rj2mypK/dc7jCLr4fGnhp2310uuNyFSIuG1CAta3jIQqB6RKveLyU0oAEovdSuM74Ui/dm9R6LnRfL/6l5cWoHkJXHQtcLxTm410d2qbEs+L5UwUicjuupPUw8KKSB0faCbzdJ+lSH2ryIusW3wZPk+LmzQjOMwpz7CAcEpIWjCwXGI2GLUxXWOQhy1PVVjlNW2Vp5b5WaT7hFoMk6KhGYOF6gLiIn7nXHa3/FtElKB4qleYL/6sVrOGWsG6Bn+aKRaOurtJX2vZVUTGZNlyzgjDkBPH6XiLe4WByFsAtrVdhSkhxoYnXZhuVHyhGu84REA5qD8sQpM3i0ECg2mvEQv9QnuADsh8AmDI/ZPy5xVUBQu2k9crJrVukzC8HhJmbIKeNljKjKK6wsLOH76nKOkwEPSrnA6qT6vT8+/C/xVfVluLnIN06Hy+kVgPnmzuek1YXZD8XpkMeGyf0bNVN7O/8NEUSP45RQ4qn16q0u+Q41nYebRBWLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNVbDJ0TGJteEJkS1g0SysyTk1RVGQreHNnQXhBeXhCclFoK0t5d1VxUTVT?=
 =?utf-8?B?T3c4Q2ZSc29seHF6Qi93YWVtRFQ1aS9weVR6R0VYYkJSNEpEYUJoZm5vclp0?=
 =?utf-8?B?QmVmejBYMXAySENoblBnbmlWUFBIN1p3U2REMm5TSWtHMmRpTFBXMDVDcm1j?=
 =?utf-8?B?L2NuL1JrcW0xWGs3RmVLYzJ5Ykgyd1ZCOW15clphbkUrOWhKM041K2haWmlN?=
 =?utf-8?B?aUU5cVUyUExzQXphdCtoTXJGN2dTTmg1cTB6bTJMQnl5MlBMV0dzd2FtdTZh?=
 =?utf-8?B?cDl0TXpzY1Yxejk4cm5MZDc0QWprV3JqbVlGbUNxNldiOEJCMXRkMTVjSGRR?=
 =?utf-8?B?cWwrcEFvQStjRmM0VUtBbi9GazdmMHdMaHFJOTB4QUxHNFUzSWhhZ0docXdH?=
 =?utf-8?B?VFZibW5OV25HUlR4VWhOdUtrbGkrWGdFcHlpYjNvTFEzQUtTNzYrY2daTkZJ?=
 =?utf-8?B?YUV6UGhYcTk2eGI4WnlTRkMzbnRwQXFIRVZHVnh2eU43c1dEREhRYTJiL3Bl?=
 =?utf-8?B?U0M3dHU2Y3NNRmp3Lzl0SU9mZDlLTTBtQTBFZGZhQzRpbHdOc1VNa2VSTXMy?=
 =?utf-8?B?TlNYc3Nac2hOU25Hc09GK1FIUDJzZ041U2JNaGc1djVCOVJJUCt6bmo1cVNs?=
 =?utf-8?B?SEtVRFlURGsvQ2RXUm9wdFltQ1dTa0svMFE4cFdObkZRU2t1enIrOGJtS1FK?=
 =?utf-8?B?RDVLcmxDdy9EbDdJUzNvNjR3ZnF3K0FCSG05SzMvd05LeUduRHZWUFZDUU82?=
 =?utf-8?B?NEQxRHlsSXh3UXZVQnRTMy9jL1hHSll1L2pkUUFjV3M2L2Vqa0sxYStVeWVT?=
 =?utf-8?B?aTNwU1I2VDJLWXhDNGxSNDQ0Vmg2Q0hMVXc2VExpekhBY0RSV0xmUEIwa3RF?=
 =?utf-8?B?NEE5UDFMa29kMmR6cWtnOVpIaGgzVGFlYTRVUSt5MjBtZXNsd0s1K3NkYXFP?=
 =?utf-8?B?cERVMDY3OW1KR29tZlU2dC9ib2hZbVBkVXBrbUJUd2g4cnl1T08wcUxtd3J2?=
 =?utf-8?B?M3ZyRlNzdXNYVitFdk9OeGZtRHBTLzAvNUpqbnFLeTYrREhOMHl5K2MrSENM?=
 =?utf-8?B?aDBVSTBFb1huMGhMSU5hV0VCUWZhWDZrUlpKTDQyZ3ZuRFRDN0hyMzM4WGRF?=
 =?utf-8?B?ZkVESnRWbDZNUXpvQWJiWk5VUW4xL3BJbU9sZS9Teit0UDFlaVpERE1zTWhW?=
 =?utf-8?B?d3dodmswMXgvWXRubW1nMjMzTGcwSlpsVFNXdlRrSlE1NkdzRkUzN3Q5RHF3?=
 =?utf-8?B?ekxvdzZhTmdVYmpKTzhnMWVwcUdQU3B6TjcvbGJwQmNNUm9wZ0dMcTBnVFp1?=
 =?utf-8?B?dkNYQ0lqOU85blpNNkM1MzJjbmVGRWdreXcvcFBOSE9oQkhZSHJUOEU5RVE1?=
 =?utf-8?B?UHUxRlMxRjVvQXBnSlIzNTUvSVliNHdyMitmY0FHOE5nbkxpUDNHcVI1amdx?=
 =?utf-8?B?akNydjhleUVETnh2ZUFVY2lmTkRHbmdNYVdXOS9wVzcrYXY4cDM1NXpWTStp?=
 =?utf-8?B?YmxXOEdFUzAvUFp3MkJpcEIxeHFWMzgreG9TRnV0MFlVaFlnRnhVTHBaVjRq?=
 =?utf-8?B?emZoWjhOUCtPcExpcUZxTjVpR3pnbk5tMjcrVHNoTWNTWEhYS0wyVWhUWlRw?=
 =?utf-8?B?SzVFclIzYy8rSzI4RlpXZ2VSaFNNNkd5OWt0UldpUnBSSDhxQlFqS3cwSXZt?=
 =?utf-8?B?L3BDSStxTkV0TFFpWmpsNzVnNTIzWU9DSkRxSXFnOVpzV1k1K0tvWUxMUE95?=
 =?utf-8?B?Mi91NHBtYk4wL1UwUE0rbVYzVmFxQmNnS2MyOHZwS2dVN1NQZzdIUmF1bXEy?=
 =?utf-8?B?d3QvU285ckRMZWpmL3Qxem11SWg0SWY1cWlLQzI5QklQS1hXaEg5L0RwZ1Zj?=
 =?utf-8?B?UXZobFl6MVF0TDBSUWRxZ2M5UUVuQm5kUWRJelNyRFcwRWEvTEJvbFY5Q0lk?=
 =?utf-8?B?SjJ0eEM2V2k3VFoyMXAybnp4MnhZV1RJbVJHRWY3S3c5WTZpbTJZSEJMZ0kv?=
 =?utf-8?B?eEVVWGFmM1NJVVZPOU1OVDFseDk5K2o1VVdJZkhuSlBYVmp2dGt0d3VuMU9Z?=
 =?utf-8?B?cDJReG9QUmFESTZ6VFU2SjdqaWN2ZXJCTnRKbUV1RUtNRkFLcS9aY1QrelVu?=
 =?utf-8?B?NzlHb21rTEhlUFFCaWJPYzkwbXQ3UGxSUExSRWFJYjFPY0dKejhiTTBacGl3?=
 =?utf-8?B?ZjZ5bDZSTFlFWEFTSUd4TXJSRHZGdmRxSDdmZVZ2S04yRE9RVVlweVJhS2Mr?=
 =?utf-8?B?d2tFeE5ZN3JXTFl2VHorbEJGY0lucDhxcWtNTEQwckpWejZnYTZTV1lZRWlY?=
 =?utf-8?Q?+RkKpQu0tLaKNnm28m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e9a1c-7c26-4b33-5869-08ded2a58f03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:36:04.6041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChziVl8eld6xIY2hQm38wdsbnshpXDaJFLU3GzkpaOImp/dDjQFaDqvTJEAP/3Ti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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

I just gave my last missing rb for this series, please push it to amd-staging-drm-next now.

We can discuss with Alex on the call today how to proceed.

Regards,
Christian.

On 6/24/26 19:55, Shahyan Soltani wrote:
> This patch series refactors amdgpu.h by moving several structures and their
> associated helpers into dedicated or existing header files. This improves
> code organization and makes the structure easier to parse.
> 
> v4:
>  - Added amdgpu_device_wb_init() and amdgpu_device_wb_fini() into
>    amdgpu_wb.h and amdgpu_wb.c and removed the "_device_" part of the
>    functions addressing v3's feedback.
>  - Removed amdgpu_uid patches (v3's patches 2 and 7) for a separate branch
> 
> v3:
>  - Dropped patch "Move struct amdgpu_sa_manager out of the monolithic header
>    amdgpu.h into its own dedicated header amdgpu_sa.h" addressing v2's feedback
>  - Removed the "_device_" part for amdgpu_wb functions addressing v2's feedback
>  - Patches 2 and 7 are unchanged but can be dropped if amdgpu_uid is not
>    desired to be removed from amdgpu.h
>  - Removed amdgpu_mqd.h and moved the relevant structs and helpers into
>    amdgpu_mes.h addressing v2's feedback
>  - Dropped patch "Move struct amdgpu_init_level and helpers from the monolithic amdgpu.h
>    file into a new amdgpu_init_level.h file." addressing v2's feedback
>  - Dropped patch "Remove #include "amdgpu_init_level.h" from amdgpu.h and add forward
>    declaration of struct amdgpu_init_level."
> 
> v2:
>  - Moved amdgpu_device_wb_get()/free() into new amdgpu_wb.c file and
>    amdgpu_device_set_uid()/get_uid() into new amdgpu_uid.c file
>    (addressing v1 review feedback)
>  - Removed v1 patches 8, 10, and 11 (addressing v1 review feedback)
>  - Moved the includes of headers amdgpu_uid.h, amdgpu_init_level.h
>    and amdgpu_video_codecs.h out of amdgpu.h into files where they are
>    actually used (addressing v1 review feedback)
> 
> Notes from v2:
> - Moving the includes out of amdgpu.h into where they are actually used
>   caused the commits to go into different subsystems like /pm.
> - Dropping patches 9, 10, and 11 is advised if this isn't desirable.
> 
> 
> Shahyan Soltani (6):
>   drm/amdgpu: move struct amdgpu_wb and helpers into separate files
>   drm/amdgpu: move struct amdgpu_video_codecs and helpers into header
>     file
>   drm/amdgpu: move struct amdgpu_mqd and helpers into header file
>   drm/amdgpu: move amdgpu_acpi helpers into new header
>   drm/amdgpu: move amdgpu_allowed_register_entry into
>     amdgpu_reg_access.h
>   drm/amdgpu: include amdgpu_video_codecs.h only where needed
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 267 +-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h      | 151 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 110 +-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c        |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  46 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   6 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  |  47 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c        | 129 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h        | 102 +++++++
>  drivers/gpu/drm/amd/amdgpu/cik.c              |   1 +
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   8 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  10 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |   6 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |   6 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c               |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   8 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   8 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   8 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/si.c               |   1 +
>  drivers/gpu/drm/amd/amdgpu/si_dma.c           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |   1 +
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |   1 +
>  drivers/gpu/drm/amd/amdgpu/soc24.c            |   1 +
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/vi.c               |   1 +
>  47 files changed, 614 insertions(+), 481 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
> 

