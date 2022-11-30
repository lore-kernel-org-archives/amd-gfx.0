Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D6C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E2B10E063;
	Wed, 30 Nov 2022 00:34:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62F710E063
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdWmefk/TBu8ZgN+dq5e+FtGSTxpnUYb+BUcRyUg3VExHyVsf1MuzYbJe3Sjrm5+mfV6L96Zy3swaVPp8JFPp2PlwjVp5xaCpJJQTgNy6kTgSc/KDWlrrclP39TEsWS4g5H7mUG9XnJlGJHXrRbN4LTRAshKcCnI+1sSZarb0Oxe8lPd7Exo6zOY0DG0HV33h/2Djx2Nxnn/oZBrGK1xiYcxmIH/u5uGiqF9NB6GTgog2V65aOoOHtkzBF1Xp/kpbdlF6idbgTFMxPtQs0brUOjTa2+n/eqU4VUbXtF/ueyxWCfOmbDL9xr+havLrxV+voMUYsOd8wjfpcJosmhs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf54h1FsaYe57eMDqOJsg48C4nkjdnBX9K5sc2kTqxU=;
 b=GhJgdTbT+tCOeYZE4wxRYgEIS+VURwteV1/3rTtpowCGIzYytXzvLWulaNHQFyaNVTAvxCenXdRlfkUBUf65T9pTCyd7fgqAxEQQt7PbcuMm83R+1+SelGU+2UEkHb+bvNjnPrRc7KG9faq3bYxrkswEHMITOn3G35Z+WuqEBUAOXLJs4OXKPStF7UFZHbre49CE0+WPET9sqYrS6HLJOpZ4rHhJL8Odgzk88tynnbXvXI2Gx4JktDb12qmvOPZbdBkXZs+3CzMY1pPSdRNWtuzVNhfXUc9piVqhUeKgKtMgwTgYl6EO0WIVgWDTE9f7yJ/VPOsaArrWZqH5yN1DFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf54h1FsaYe57eMDqOJsg48C4nkjdnBX9K5sc2kTqxU=;
 b=u4i69QM8dztLzc1nKMfysvO+e3nGFHutu/3s+e3NrMhPc3Lfym7IONy8asJsBSBJ2X5ya9roeWWAp7j4XtsTid6ULuyjyKDzAsk5ilucWCGGGMjVF/Ow3hyLl0RB5/Srfg02HIq9EBxW1hL7uMn04AGpPFzUWCJMIxZSogTdbRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:34:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:34:06 +0000
Message-ID: <3cab8f6f-6f68-fba4-b270-7f7ae56984b4@amd.com>
Date: Tue, 29 Nov 2022 19:34:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 23/29] drm/amdkfd: add debug set and clear address watch
 points operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-23-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-23-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: f4afa97e-3ad2-4e93-b108-08dad26a96f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoV3/v2r/IX8YJDhUDq4QcV96wsjRsH4QhBmehgS0tCWmY0Ryld+Wj5+P9LaGw9dqNwrKJvOy8YjR6Nbm2xqSXJfrqJb+vpZ+HyyY8K7QiBxEDwrWAXNm0LmYlevaRg29BQvff7zxoWfyLID6YsNnFd0Qp/1jxCEU4oPNmeNlbrP4uSHV1d1PND3H8yh6+maQWQ3Tn7ujYxp9NTzA+RSe5f63v6HrKHT38j0uUM31r1EnWsn+i0dKlM+e/2Cqw/XboJwIkyfbMEaOKHH1+0JFKnYCFOEGVmAlRJZJJFZ23jzx5S0chV7oWps3uiQ9b9K3bvHWxGJcTOS+Hdc9lmFDDb3ciOFfz5zyIWi0LFijGPe9wcnDhYroasvWjHaFxviOzPI2ynqzMTXOSeosq6I7/sPlEHg9s2yCibO4U8L5DgMsYPxBOlldLG9K3hoiSiTNm2BN7dZMwyb6a/yoA91PAhP93gc5JI3+9x7IeVKfWHv78AFFMtYcWXTK6wRcHNHY6ViJVh/KRd7JRsHLPcL8SQWhBZRI73fv8QA0B7G1aiQWPmmAJMLcgkt5z0eKrRuZhjbnuxPqnPG96j5p3r8ubiPSjuTKFbUb0IIK4LwWrcV9oUOSZ1r2ai5pQAfHyb77sKCKhQu3heIAbffBuRPUgUyFFYH1tCNZJelT4vCJgNFbG1eMgPVv4GAuvXC14gGVldYd1QlcEZYy9aBKjjNHayU5fsNhP4wjnUHU10sb00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(6512007)(2616005)(36756003)(31696002)(41300700001)(36916002)(6486002)(6506007)(86362001)(53546011)(5660300002)(30864003)(478600001)(316002)(8936002)(8676002)(2906002)(66946007)(4001150100001)(66556008)(66476007)(186003)(26005)(44832011)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlo0Y1VCMnhzYWdQZVJxQjVWaTY3dGROQ2JyNStDQXQvRkUrbm9ocmFnZ3hB?=
 =?utf-8?B?N3lvTGJZbjVTa2hLeFY4NjhMRnE4dlR3K3JrU0dMZW8wQlZkLzYwV1k4RTZB?=
 =?utf-8?B?bmFrQnBYQVhEdVR3ZmplV2hOenFjOEdVMkVDTGF0K3FDMFM3MXQyM3dZbTZX?=
 =?utf-8?B?TXVhektlYUdvVUJrQjZmaWEwU0RTUy9GZG9qck45QmdWUVkxUEZZUUhsYUd2?=
 =?utf-8?B?WEM4bHRsYVBLSHUvNnV0TDErK0dtRThsTEFsUkxTcGlVRHdJZHNjbTZZZjZI?=
 =?utf-8?B?WlVtUGZ1ME5Hd1laRVJWT0pyUlhWTUF1MlZock9nNGhxaUtNL0VwNGdBbWMv?=
 =?utf-8?B?Qmh3N3lueG9JS3dJMjNhQ3l3bnBXMXB0USs4WWpoMU4xcWhWU05FMFRiQ3hW?=
 =?utf-8?B?VVA3dlV4UW11WjV3SjdyRXdsQmJtV05ZTHhLYWZaWHphNDFuZjJ4U3NGeWo3?=
 =?utf-8?B?MzA1Q0dHaU1qR1N0elhyNXBudDFPQTlLbzMwSzhJR2JnMWVieUswMkQ0bktN?=
 =?utf-8?B?ME9sQ0U1eXZVekt0QmpPWnBUdXdSRDArUXlwS3FsOEExVnZJM0ROdHc0bGxN?=
 =?utf-8?B?dlN6UFEwWHJVQlJyQm5TNlAxb20yZGNIN2UzNmtoZS9SbkUvUkF2SnpUd21G?=
 =?utf-8?B?QmthOUFudEFIY00yRThMTEhXMnNqck9MTDg2QTAyL3NmWWUwMzhYcnJRQkNK?=
 =?utf-8?B?Q3RZWkMycUNhTTZKSGJhK0JGUmlKM2xKNk9LdlNQQ0JLZU1obEhwUUhmNllh?=
 =?utf-8?B?Y1cxNXVqNmE3ZXVnSGMzLzFXUWxGUkNQbjNYMldjUzJ4b0h2YmJnRVdXdFBi?=
 =?utf-8?B?KzRsamtYYUxWQ2JHK1hBVjcxOXNGTG1zdVUxNDhsNGFjWHNTUWcrMEJrVmpW?=
 =?utf-8?B?RTlXdGoxQXhLOUYxTllpTGdzUy8vYU5XMURuTkkvbk1CemgyUGNXeVVzN1Ar?=
 =?utf-8?B?TzdPamRWUlBnNXNueUFQb3N3ZGZKZGFNSTA1SlNxaGlNc0wzTTBwU3dNZVpt?=
 =?utf-8?B?eUZwUTdodzJvQUdPZlNsS09vSVpPRisyTVl0L1RGVmpacUVRNGJLT0l6TGZa?=
 =?utf-8?B?ZzExTUx4WDZ5Q1cxU040aDNHYmsyRlFBQXlXRVJ2TC9ZeTJIMFpINGZUWXd0?=
 =?utf-8?B?YUd6NmxDQk1ZMHl0RFFGcVd1czhFZlYzaWhIZmZ2QkdkbDM5SjF1RDFkZ1Va?=
 =?utf-8?B?eUdndHJtbG5kSWlmUWZNcGtCcnpDclZJTVpXQjRvM2E1d1RsNXJxUFBnUTlJ?=
 =?utf-8?B?a0lyM0lqYm1SQW9xRnJ5U3FSVGdScCtFUHpNNUFCdlBEWTNWb20rWGNaNDRX?=
 =?utf-8?B?bXB0VXVGYUp5V2g3NTZzSjkvZ0xHN1FvVitZSS9qclJIN1VsOTQwNGFEaXk5?=
 =?utf-8?B?NjlSeGcyKzZkUlJ4SlZmcDQydUhxVml3UkNXenY3dDNOWG52dytCMGhNSm1v?=
 =?utf-8?B?ZmFzWnYyVnRKNU0yTDZqd014UkhVUWJ5OHE5Mm5vc2gxRjlicGhjVk9RS2hM?=
 =?utf-8?B?MElGc2R5SEVPWEF6QzFjUXhnSUxvQ1prZWttclVRMG05Sjc3TmowVjhNTEFP?=
 =?utf-8?B?QkhXdWtJK3BoYnFTZWhJWEpIK2MrZ0J3Q0JyaUNMaWtCaUwrbTM0Qm96VXky?=
 =?utf-8?B?ZElWWXBBSXJKeTdocU5aSDBncjEvUmlycHFKbkpWZHpvRVdlbnNCQVdFK0M0?=
 =?utf-8?B?Z2M3WStxM3hzY3RyYTA5UEhYSFhXcTBZWWxWN1hDUUVTbFJ4M1BMa0E1WFZR?=
 =?utf-8?B?TE05Ynh0dmh6K0pOcDByTEtmT1dUbUloRkJnQjA4TmN0WW1MS3pYUzU3dERk?=
 =?utf-8?B?dTRvR2MxL29nSUd4NHllM0JMVmpIYTZnZzByNFBBNEEzQnBmQm9aZ0pXK1pH?=
 =?utf-8?B?N2pvUzRQOEFjSnNyMDVFZ3JBQmxVUU1JdjNwUkZhSUFEb2lMekFCbWFwSCt1?=
 =?utf-8?B?ejl6MS90UDV5emlVM0FoQUhFMUkyREltVStmbUtHM0psL2k1OXBMcDh3L3Fq?=
 =?utf-8?B?NkVKL21qQ1AydVljWnhoVlBNbmxwTTZYc2FIQTVOdGh4TE42UVNqcDYrQUVz?=
 =?utf-8?B?VXgrMk5UV0JqYU5sZzJzV0dUT2srcGZIT3psR2hoc00yV3RRT2M1aS9QQVlZ?=
 =?utf-8?Q?hFu4J0QAJp6aVVmNxGfrmKsaJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4afa97e-3ad2-4e93-b108-08dad26a96f2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:34:06.8762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZBA9vnl0cSeUnVk9+/BzfAvhnuglJqZCl3IwI6l37ZKRPnGG2Yb/uJHUwEAaehq/FMIA40WdVNVMFI50kVA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Shader read, write and atomic memory operations can be alerted to the
> debugger as an address watch exception.
>
> Allow the debugger to pass in a watch point to a particular memory
> address per device.
>
> Note that there exists only 4 watch points per devices to date, so have
> the KFD keep track of what watch points are allocated or not.
>
> v2: change dev_id arg to gpu_id for consistency
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Nit-picks inline.


> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   2 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   2 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  78 +++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   8 ++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   5 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 128 +++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   8 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  24 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 130 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   8 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |   7 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 +-
>   12 files changed, 405 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 91c7fdee883e..8f9b613e3152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -138,6 +138,8 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
> +	.set_address_watch = kgd_gfx_v9_set_address_watch,
> +	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 10470f4a4eaf..5d6bd23a8cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -400,6 +400,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
> +	.set_address_watch = kgd_gfx_v9_set_address_watch,
> +	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 66a83e6fb9e5..ec48677772f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -880,6 +880,82 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +#define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H - mmTCP_WATCH0_ADDR_H)
> +uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode,
> +					uint32_t debug_vmid)
> +{
> +	uint32_t watch_address_high;
> +	uint32_t watch_address_low;
> +	uint32_t watch_address_cntl;
> +
> +	watch_address_cntl = 0;
> +
> +	watch_address_low = lower_32_bits(watch_address);
> +	watch_address_high = upper_32_bits(watch_address) & 0xffff;
> +
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VMID,
> +			debug_vmid);
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MODE,
> +			watch_mode);
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MASK,
> +			watch_address_mask >> 7);
> +
> +	/* Turning off this watch point until we set all the registers */
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VALID,
> +			0);
> +
> +	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_high);
> +
> +	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_low);
> +
> +	/* Enable the watch point */
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VALID,
> +			1);
> +
> +	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	return 0;
> +}
> +
> +uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> +					uint32_t watch_id)
> +{
> +	uint32_t watch_address_cntl;
> +
> +	watch_address_cntl = 0;
> +
> +	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	return 0;
> +}
> +
> +
>   /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -968,6 +1044,8 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
> +	.set_address_watch = kgd_gfx_v10_set_address_watch,
> +	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
>   	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.program_trap_handler_settings = program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 34c04a2bb83b..334ff16e25db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -39,6 +39,14 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
>   					 uint8_t wave_launch_mode,
>   					 uint32_t vmid);
> +uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode,
> +					uint32_t debug_vmid);
> +uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> +					uint32_t watch_id);
>   void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
>   void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 8627c5458973..ee36ba045dcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -676,6 +676,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
>   	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
> -	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode
> -
> +	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
> +	.set_address_watch = kgd_gfx_v10_set_address_watch,
> +	.clear_address_watch = kgd_gfx_v10_clear_address_watch
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 3bba7ca21926..98355a21740b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -810,6 +810,132 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +#define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H - mmTCP_WATCH0_ADDR_H)
> +static uint32_t kgd_gfx_set_multi_process_address_watch(
> +					struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode)
> +{
> +	uint32_t watch_address_high;
> +	uint32_t watch_address_low;
> +	uint32_t watch_address_cntl;
> +
> +	watch_address_cntl = 0;
> +	watch_address_low = lower_32_bits(watch_address);
> +	watch_address_high = upper_32_bits(watch_address) & 0xffff;
> +
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MODE,
> +			watch_mode);
> +
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MASK,
> +			watch_address_mask >> 6);
> +
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VALID,
> +			1);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_high);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_low);
> +
> +	return watch_address_cntl;
> +}
> +
> +uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode,
> +					uint32_t debug_vmid)
> +{
> +	uint32_t watch_address_high;
> +	uint32_t watch_address_low;
> +	uint32_t watch_address_cntl;
> +
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))

Shouldn't this be handled by putting a different function into 
aldebaran_kfd2kgd.set_address_watch?


> +		return kgd_gfx_set_multi_process_address_watch(adev,
> +							watch_address,
> +							watch_address_mask,
> +							watch_id,
> +							watch_mode);
> +
> +	watch_address_cntl = 0;
> +
> +	watch_address_low = lower_32_bits(watch_address);
> +	watch_address_high = upper_32_bits(watch_address) & 0xffff;
> +
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VMID,
> +			debug_vmid);
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MODE,
> +			watch_mode);
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			MASK,
> +			watch_address_mask >> 6);
> +
> +	/* Turning off this watch point until we set all the registers */
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VALID,
> +			0);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_high);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_low);
> +
> +	/* Enable the watch point */
> +	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +			TCP_WATCH0_CNTL,
> +			VALID,
> +			1);
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	return 0;
> +}
> +
> +uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> +					uint32_t watch_id)
> +{
> +	uint32_t watch_address_cntl;
> +
> +	if (adev->asic_type == CHIP_ALDEBARAN)

Same as above.


> +		return 0;
> +
> +	watch_address_cntl = 0;
> +
> +	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
> +			(watch_id * TCP_WATCH_STRIDE)),
> +			watch_address_cntl);
> +
> +	return 0;
> +}
> +
>   /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -1081,6 +1207,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
> +	.set_address_watch = kgd_gfx_v9_set_address_watch,
> +	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 2a2ab42037e4..ba52b61b68c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -77,6 +77,14 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   					     uint32_t trap_mask_request,
>   					     uint32_t *trap_mask_prev,
>   					     uint32_t kfd_dbg_trap_cntl_prev);
> +uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode,
> +					uint32_t debug_vmid);
> +uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> +					uint32_t watch_id);
>   void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
>   void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ec26c51177f9..9b2ea6e9e078 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2797,6 +2797,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	struct task_struct *thread = NULL;
>   	struct pid *pid = NULL;
>   	struct kfd_process *target = NULL;
> +	struct kfd_process_device *pdd = NULL;
>   	int r = 0;
>   
>   	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> @@ -2864,6 +2865,20 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		goto unlock_out;
>   	}
>   
> +	if (args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ||
> +			args->op == KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH) {

Weird indentation.


> +		int user_gpu_id = kfd_process_get_user_gpu_id(target,
> +				args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ?
> +					args->set_node_address_watch.gpu_id :
> +					args->clear_node_address_watch.gpu_id);
> +
> +		pdd = kfd_process_device_data_by_id(target, user_gpu_id);
> +		if (user_gpu_id == -EINVAL || !pdd) {
> +			r = -ENODEV;
> +			goto unlock_out;
> +		}
> +	}
> +
>   	switch (args->op) {
>   	case KFD_IOC_DBG_TRAP_ENABLE:
>   		if (target != p)
> @@ -2917,7 +2932,16 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				(uint32_t *)args->resume_queues.queue_array_ptr);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
> +		r = kfd_dbg_trap_set_dev_address_watch(pdd,
> +				args->set_node_address_watch.address,
> +				args->set_node_address_watch.mask,
> +				&args->set_node_address_watch.id,
> +				args->set_node_address_watch.mode);
> +		break;
>   	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
> +		r = kfd_dbg_trap_clear_dev_address_watch(pdd,
> +				args->clear_node_address_watch.id);
> +		break;
>   	case KFD_IOC_DBG_TRAP_SET_FLAGS:
>   	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>   	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index afa56aad316b..68bc1d5bfd05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -24,6 +24,14 @@
>   #include "kfd_device_queue_manager.h"
>   #include <linux/file.h>
>   
> +/*
> + * The spinlock protects the per device dev->alloc_watch_ids for multi-process access.
> + * The per-process per-device pdd->alloc_watch_ids is protected by the debug IOCTL
> + * process mutex.
> + */
> +#define MAX_WATCH_ADDRESSES	4
> +static DEFINE_SPINLOCK(watch_points_lock);

This spin lock seems to be a left-over from when we managed watch-points 
globally. Now that they are per device, I think this spinlock should be 
per-device as well, in struct kfd_dev.


> +
>   void debug_event_write_work_handler(struct work_struct *work)
>   {
>   	struct kfd_process *process;
> @@ -227,6 +235,127 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   	return 0;
>   }
>   
> +#define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
> +static int kfd_dbg_get_dev_watch_id(struct kfd_process_device *pdd, int *watch_id)
> +{
> +	int i;
> +
> +	*watch_id = KFD_DEBUGGER_INVALID_WATCH_POINT_ID;
> +
> +	spin_lock(&watch_points_lock);
> +
> +	for (i = 0; i < MAX_WATCH_ADDRESSES; i++) {
> +		/* device watchpoint in use so skip */
> +		if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
> +			continue;
> +
> +		pdd->alloc_watch_ids |= 0x1 << i;
> +		pdd->dev->alloc_watch_ids |= 0x1 << i;
> +		*watch_id = i;
> +		spin_unlock(&watch_points_lock);
> +		return 0;
> +	}
> +
> +	spin_unlock(&watch_points_lock);
> +
> +	return -ENOMEM;
> +}
> +
> +static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
> +{
> +	spin_lock(&watch_points_lock);
> +
> +	/* process owns device watch point so safe to clear */
> +	if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
> +		pdd->alloc_watch_ids &= ~(0x1 << watch_id);
> +		pdd->dev->alloc_watch_ids &= ~(0x1 << watch_id);
> +	}
> +
> +	spin_unlock(&watch_points_lock);
> +}
> +
> +static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
> +{
> +	bool owns_watch_id = false;
> +
> +	spin_lock(&watch_points_lock);
> +	owns_watch_id = watch_id < MAX_WATCH_ADDRESSES && ((pdd->alloc_watch_ids >> watch_id) & 0x1);
> +
> +	spin_unlock(&watch_points_lock);
> +
> +	return owns_watch_id;
> +}
> +
> +int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
> +					uint32_t watch_id)
> +{
> +	int r;
> +
> +	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
> +		return -EINVAL;
> +
> +	r = debug_lock_and_unmap(pdd->dev->dqm);
> +	if (r)
> +		return r;
> +
> +	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
> +							pdd->dev->adev,
> +							watch_id);
> +	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> +
> +	r = debug_map_and_unlock(pdd->dev->dqm);
> +
> +	kfd_dbg_clear_dev_watch_id(pdd, watch_id);
> +
> +	return r;
> +}
> +
> +int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t *watch_id,
> +					uint32_t watch_mode)
> +{
> +	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
> +
> +	if (r)
> +		return r;
> +
> +	r = debug_lock_and_unmap(pdd->dev->dqm);
> +	if (r) {
> +		kfd_dbg_clear_dev_watch_id(pdd, *watch_id);
> +		return r;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
> +				pdd->dev->adev,
> +				watch_address,
> +				watch_address_mask,
> +				*watch_id,
> +				watch_mode,
> +				pdd->dev->vm_info.last_vmid_kfd);
> +	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> +
> +	r = debug_map_and_unlock(pdd->dev->dqm);
> +	/* HWS is broken so no point in HW rollback but release the watchpoint anyways */
> +	if (r)
> +		kfd_dbg_clear_dev_watch_id(pdd, *watch_id);
> +
> +	return 0;
> +}
> +
> +static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < target->n_pdds; i++)
> +		for (j = 0; j < MAX_WATCH_ADDRESSES; j++)
> +			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
> +}
> +
> +
>   /* kfd_dbg_trap_deactivate:
>    *	target: target process
>    *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
> @@ -241,6 +370,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   
>   	if (!unwind) {
>   		cancel_work_sync(&target->debug_event_workarea);
> +		kfd_dbg_clear_process_address_watch(target);
>   		kfd_dbg_trap_set_wave_launch_mode(target, 0);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index ca3ab1f01985..ad677e67e7eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -50,7 +50,13 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   					uint32_t *trap_mask_supported);
>   int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
>   					uint8_t wave_launch_mode);
> -
> +int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
> +					uint32_t watch_id);
> +int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t *watch_id,
> +					uint32_t watch_mode);
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
>   					unsigned int queue_id,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 8aebe408c544..733987de595a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -395,6 +395,8 @@ int kfd_init_apertures(struct kfd_process *process)
>   			pdd->gpuvm_base = pdd->gpuvm_limit = 0;
>   			pdd->scratch_base = pdd->scratch_limit = 0;
>   		} else {
> +			int num_watchpoints = pdd->dev->device_info.num_of_watch_points;
> +
>   			switch (dev->adev->asic_type) {
>   			case CHIP_KAVERI:
>   			case CHIP_HAWAII:
> @@ -424,6 +426,11 @@ int kfd_init_apertures(struct kfd_process *process)
>   				pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>   				pdd->qpd.ib_base = SVM_IB_BASE;
>   			}
> +
> +			process->max_watch_points =
> +				!process->max_watch_points ? num_watchpoints :
> +						min(num_watchpoints, process->max_watch_points);
> +
>   		}
>   
>   		dev_dbg(kfd_device, "node id %u\n", id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3d529c7499f8..aee4fe20e676 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -348,6 +348,9 @@ struct kfd_dev {
>   
>   	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>   	struct dev_pagemap pgmap;
> +
> +	/* Track per device allocated watch points */
> +	uint32_t alloc_watch_ids;
>   };
>   
>   enum kfd_mempool {
> @@ -796,6 +799,7 @@ struct kfd_process_device {
>   	uint32_t spi_dbg_override;
>   	uint32_t spi_dbg_launch_mode;
>   	uint32_t watch_points[4];
> +	uint32_t alloc_watch_ids;
>   
>   	/*
>   	 * If this process has been checkpointed before, then the user
> @@ -907,6 +911,10 @@ struct kfd_process {
>   	/* per-process-per device debug event fd file */
>   	struct file *dbg_ev_file;
>   
> +	/* Allocated debug watch point IDs bitmask */
> +	uint32_t allocated_debug_watch_point_bitmask;
> +	int max_watch_points;

These two variable are unused.

Regards,
   Felix


> +
>   	/* If the process is a kfd debugger, we need to know so we can clean
>   	 * up at exit time.  If a process enables debugging on itself, it does
>   	 * its own clean-up, so we don't set the flag here.  We track this by
> @@ -952,7 +960,6 @@ struct kfd_process {
>   	struct semaphore runtime_enable_sema;
>   	bool is_runtime_retry;
>   	struct kfd_runtime_info runtime_info;
> -
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
