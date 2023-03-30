Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C000DC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B6B10EE46;
	Thu, 30 Mar 2023 13:49:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A84710EE46
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2OmELO6/kQmY/O3FJ9eKO0ouLNyYAmnoHeEIs1UyEtliyQlL+TGcdliW3uxRozgmbxCw9NTBBJNmaA8S7694mZdBWzFw69YMUTykey5oJ1TQIr6F1+zmFRRLoWHXzvctY8Kx4oF4vmCQCNtqXL0A8IzGOtIcGtBNbHesOUAXUUgi/jW2+ujXmHccxTdt0VpFaNicDf2SSj62rLSQMksIYq8GMhj21dw4VGgQ/v+PcR/B5jbXre0vduoX/VWRFLbYthWUGO+piWcsuKqCh2jbOWj9NhkY+rviDegmz4ZsEG3os2gRUqx5plaXM5UxLGkz0Dcyti1k0sZy+w3gQVgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8777iwN8OjN3Qibyd8uBCP5wHHpG6X3kDi2dUblQrQ=;
 b=K4Cz5O0UQvdepVlV9b2O590v9Ptz2OM5uQfTJ0fOwBinW+A8c+ghFoT5iJjYoR14kwqlnFDTkBlYa2spjV0N1kBrh5siVsvA+quYv6vl/F5bKuZzxM9OUayQ2OSxzuzpiBMQ1tcV7+GTX925Ryde8SNzsqQEHqPg3ihIyXU7HnfGxBL0Ojko9EFryASW3zl5T0s+psdj4qhnkXylzF3W6p/oVBJXUug9BainrrMR14cfE1pzGxrMe9mgvv9QvPzIjqcv1J4XbS/7ZbYxQ8ObUZ6twTlDEo0LNYIaZczSfxsK0JQxaGcu0+Cnlf0DEhcZUwFZeQiUVI/yZAjzWe0XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8777iwN8OjN3Qibyd8uBCP5wHHpG6X3kDi2dUblQrQ=;
 b=BNpP57E8PWkiWXajEqJXIMtM3Jm97sLJtqS2ITUB7NIN2JadneEOWW1UszqECuQabyVE5y4MKjaRpdyFPl7Mli5LMEwGEWWBkvbtlRuN2eQDA79j5NXMe9wSCOpuQkGupdqKTUBpyKMEGtFEozfrW0PaVw3wJCWb89qK92PDDso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.32; Thu, 30 Mar 2023 13:49:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:49:34 +0000
Message-ID: <6effdd2f-b73d-1b10-4eb6-1c8563d98fc2@amd.com>
Date: Thu, 30 Mar 2023 09:49:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 00/16] AMDGPU Doorbell manager
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d84a967-10d9-4831-ed8b-08db31259854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1U50ExrYnrPGgYWB2gTw+GiXocsiaiVUVeEYyECCk0LDfiFlyKrWoZRzm9nC2rWhqNblYsPSUJ0TAmOQXs4e9XFBUEEY9foM5V8TQF8Ejn3T3ozCf1XBgmgDOAl4GfTz6saLgEDg/Ks9LTzaM7WXHkAG2QvpZSBB1lkxpIMf709S2fyRyXqGLfqji4CwUq3DXDo3M/MulVAR3AfpJyUI+XoY4AZWfU2Y8oMKZLqSCwiUpupS9QlbeOlW0DAWJACCziT+1Pq6FLw2wvjL8wzr7cpzuuWHsfpCIH0mUOFTR6wGbeOKWEg4sUQfuWMoIJEeVYYZqhCmvu5NqeCdaTmBRJrR+GZOmDsmdKIREqD4kn4D8AUN3McZLKMo9oLtE1Jy+IrGvs54wKGZiU4/YdZBjD+aqrqc27Jj03XdIawmji1RMlhZ7OkZmrc6M293jje1NLbB7AHnaSclwb/jdNTWCPRcTSy8HGeRan1Gi1LZyOT3H02t84NIggSlq+ILLj/Amy2P/RjEJm8AjpgpuzMePX5119bdGHbQwLFxoFszqJToGGGyoUX+17iUWLkpCianT9LsNLq2gCP/JXXTWB0c5WDMP9EsOCzLmV/vynmwVSxvR1Xj30K1SZKK/PYXtD2f5StK0vjgrSGQHj/N+b63jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(5660300002)(53546011)(316002)(66946007)(66556008)(66476007)(4326008)(44832011)(26005)(41300700001)(8936002)(54906003)(186003)(83380400001)(2616005)(8676002)(6486002)(6666004)(6506007)(6512007)(36756003)(31696002)(38100700002)(86362001)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJxTnY0ZFlHdnQ1SG8zNkdhZW0yMHZvSmh6LzY2eThvYTlrSFVneGcwTXJ4?=
 =?utf-8?B?eFoySERFUjlYZ2dqWGY2RmZHZWxxa0Z4Z1kwSmVGSTJXSDUvdUtzNE12cElX?=
 =?utf-8?B?Rk9meEN4ZnJZYzFSTjhDVlJSOHZpdHJ6cjNWSU1CN1hILysraUNrdS9sWGdB?=
 =?utf-8?B?SEV4S2NIMHcxMUIvZjNZcVBabm9ZUXlFWkNBR2NtOEdIaWFaKzdscDl0eU5D?=
 =?utf-8?B?RWlRTHlMZi9LTVIxd2RUbVljVmp5R01TTjZLRG1SaUZNNk1DSTNOZmlxVGFX?=
 =?utf-8?B?OE9Wa3FPU215Q1pXUjBQZnRmeEEzSGg4MGZNQjQrVVZLVld1dTFnQ28wUjBM?=
 =?utf-8?B?NSsvQThLRVllRzVTSWcycGdSUUFNMTZ3U2dVWSt4dVZZb1BoOThpRFBxeUlm?=
 =?utf-8?B?bTNwcHZvaVdWbjRaRitPdDBRZnI4QzVIellPZnREeHdjR0hGSE9LMDdHMmE1?=
 =?utf-8?B?QlBUQU9aOFM0blVhUjZlTWozdlBrTmlaZG5BV21xZk8wWTRpVGZQQVlxUklU?=
 =?utf-8?B?QUJseUsvRlBwL2ZGcWxUOGVLNDI2emdUcjhjZGorOW44Z2FiK3Q1ZXpFMEFC?=
 =?utf-8?B?dUVEV2hrbHJ5U0ZNbUFJU2dyN3ptZ21NU3hGNDc2ZVdxNkF0YlhaSmhaR1o3?=
 =?utf-8?B?YjJ4cnd0T0daa2FCZVdjcjVZQW9kZC9PV29RekNCZG16emdEYTcxeWhMeGNN?=
 =?utf-8?B?RVJkVVBNS21HTUFiUUI5Z1hFaHhxRFZOdGFrN0I2eWhIUE5QM0libWp1MHd2?=
 =?utf-8?B?TWpwUm1obk1LNEVtc3pYdXdxNU01VnUvT1hBekM4NTN3VEV0Q0hVWkJvY0t1?=
 =?utf-8?B?b1JjSm1pQVNZUHZWMmVKdGFyRHVMOEFEclhIN2NFaXBOUmxKcFNBbGljblU0?=
 =?utf-8?B?WDRkellLMktUVUdoRk1OUFRpeUtkMitUanM4RHdpTmVHNkFPUW5kNHA2YXJs?=
 =?utf-8?B?Qk1yT3hPcHA3bWxRbWVxdnVodTNlamhEWXh3YjVzZjdWS0VqYWlUTWNGNWpN?=
 =?utf-8?B?YisxUmtIbnFHZWN1dzZnZ1JvVXlzeThUeDJYUWNSQktBalIxeWQxNE1ac0kw?=
 =?utf-8?B?VUlhbE5kcmd4MkJLZmpvVmR2bXhHcU04b1p2SXV5dnp1QWQyK1VCdktYQU1s?=
 =?utf-8?B?VkhTRGdESDUremVBWHhlcTUzeThFMWFHN1A4REwvUGhHczJrckg2QksvQ0tF?=
 =?utf-8?B?a3c2NU1IcTVueGFSRFRRUUxkUndGZXBVbXJhN1UwSEpCaGxVcHdDWlFKSGF0?=
 =?utf-8?B?RUx6Y2U2MXFuNktEREczOTh2YW94bVFOdDBuY0ZVRndhVW9meFVZYjFKWmNv?=
 =?utf-8?B?bDZhUmowYkNValE3bkU5MlJ1Z1A4VlcvNE16YW9uK0lKajRRYndIRktUSHhG?=
 =?utf-8?B?R0FVOC9QUVZxaSt5dkVoMHpmZWlWRDd4ZG4yM1YyQlJ1K0lKUWw3TFVYUUsy?=
 =?utf-8?B?bXo5VEdJWU0xT0x4Y2NXU2YxVmxGZUJOSzdsckFnT2VzUFFCWVNXa3A3L0NW?=
 =?utf-8?B?OVFXYW5oa3lUSWhnVk5OSzcydDFlVjZYTDRGck02eVAwMHI0K0xrYUhFQzVW?=
 =?utf-8?B?QklEcUs3cGpWQWdyU3VIUFJoYTlqMlgxWXdSU05pajJTbENiUS9WOVpJZzNK?=
 =?utf-8?B?N25ycDh5L0dTT29FNlQwQ2wzM2hXZ0daM044UlJEekxhOTZjcm1ZZm01MUNa?=
 =?utf-8?B?a1RPdDl0RmVnMWZMUXN5RVd2cjc1b3pmNkgyVWF0RStZSmtaNFR3OXdycWlj?=
 =?utf-8?B?WkQ2K0RQNVNZOEVGTEZRQXViYWtoMHk4enBSOEZObnhkSTFXQ00rdVZyQlBm?=
 =?utf-8?B?clMza0k2UG9DYThONkJkK0ZlR0Fma0Q2bmsyVWtkNHRocFRrRHBqdzVBcmtZ?=
 =?utf-8?B?QmR5bTNWTncvVC8yMlB0NmFpYUhJbTlvZ1MxYXltSkUrWURqUXFZTUkrdHhl?=
 =?utf-8?B?T2Z4UzR2SEtZUTJNUTJESFNmeUcvcGRlNDJibTA0THlaU2RpQWw5MDFqRm5i?=
 =?utf-8?B?aFVDV2VhaEkyRjJrMVhxd1M0bUVFcGF1dXlIYWIvVVNyM0ttRi93N1RHdFAy?=
 =?utf-8?B?dGNQYlJkRmwreXFYbDErOVpMYTNlWWdsNjNibnhrMTVTd01vR1Jia1Z4a0lV?=
 =?utf-8?Q?I6Up2QI6Doa7eO8UBMojhCHS2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d84a967-10d9-4831-ed8b-08db31259854
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:49:34.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/l/NhQ0f23JZxpORdd107KjhPyF2YEEzgzHu6GN4VXsV0/JUyhuTuwTaNv8aHeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As I'm reviewing this, it is obvious that this patchset hasn't gone
though scripts/checkpatch.pl.

It's good practice to run one's patches through scripts/checkpatch.pl,
to see deviations on common Linux practices, and correct them.

Regards,
Luben

On 2023-03-29 11:47, Shashank Sharma wrote:
> The doorbells in AMDGPU drivers are currently managed by different
> users in a scattered way, across the driver. The existing clients are:
> - AMDGPU graphics driver for kernel level doorbell writes.
> - AMDGPU MES module for kernel level doorbell write (MES ring test).
> - AMDGPU MES modules for kernel level aggregated doorbell writes.
> - AMDGPU MES module for MES process doorbell writes.
> - AMDKFD module for KFD/KIQ kernel doorbell writes.
> - AMDKFD module for KFD process doorbell writes.
> - AMDGPU usermode queues for usermode doorbell writes (upcoming).
> 
> This patch series introduces Doorbell-manager to keep the doorbell handling
> at a central place. The fundamental changes are:
> 
> - Introduce and accommodate a new GEM domain for doorbells.
> - Prepare the AMDGPU ttm backend for handling doorbell allocation.
> - Introduce doorbell-manager functions to allocate, free and index
>   doorbells in one unique way.
> - Create doorbell BOs for kernel-level and process level doorbell
>   opertations, and place it in existing structures.
> - Modify the existing graphics, KFD and MES code to use the
>   doorbell-manager functions.
> - Remove the existing doorbell management code in KFD/MES.
> 
> PS: This series has been sanity tested with kfd_test_suit to ensure
>     it is not introducing any regressions due to kfd doorbell changes.
> 
> The idea is that:
> - a kernel client can call doorbell manager functions to allocate/free
>   doorbell pages.
> - a usermode app can directly allocate a page from the doorbell bar just
>   like a GEM object and use it for different usermode queues.
> 
> Alex Deucher (2):
>   drm/amdgpu: add UAPI for allocating doorbell memory
>   drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
> 
> Shashank Sharma (14):
>   drm/amdgpu: rename num_doorbells
>   drm/amdgpu: include protection for doobell.h
>   drm/amdgpu: create a new file for doorbell manager
>   drm/amdgpu: don't modify num_doorbells for mes
>   drm/amdgpu: add helper to create doorbell pages
>   drm/amdgpu: initialize ttm for doorbells
>   drm/amdgpu: create kernel doorbell page
>   drm/amdgpu: validate doorbell read/write
>   drm/amdgpu: get absolute offset from doorbell index
>   drm/amdgpu: use doorbell manager for kfd kernel doorbells
>   drm/amdgpu: use doorbell manager for kfd process doorbells
>   drm/amdgpu: remove ununsed functions and variables
>   drm/amdgpu: use doorbell mgr for MES kernel doorbells
>   drm/amdgpu: user doorbell mgr for MES process doorbells
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 102 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 304 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 165 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  17 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  11 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  31 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  13 -
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  16 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 198 ++++--------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  23 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  26 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  16 +-
>  include/uapi/drm/amdgpu_drm.h                 |   7 +-
>  19 files changed, 636 insertions(+), 472 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> 

