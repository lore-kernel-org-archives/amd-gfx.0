Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB3BC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 10:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A1210E0FF;
	Tue,  6 Jun 2023 10:33:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7233910E0FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 10:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSNno8SIbO0KImUPAcWzd0rhHs0X2/ot2EsCAaUvLtoYDzkz6WQtFoSjrr5Re1/1S4Buc0+KprBiA7dAVFPmn7HLHlCZP5qwrB24e4m6R+mklTN/HkO6bua0A1XkJSqMfqvwsGsspwvmUSb9abVvHnGfEifgWUdtln0kIVlu13ocqCJrBX/GkP+x4WEz/1lUHtT6BgDEuyKCV72tZKYRI1oYuxYNM+mzphASj3uFGqTXI9V9Qs4OMcwVaq9o9dybbxJ61FVw6qXEVjt/bV9M52H8u79L08tEB5WJP2aWPhHMGeH7FS3OC5uq05+bi6QWsnG+O6kyTuV1NXJNVUYrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMyvSnUNWTvCa19IAQvR1yIaFsif3911D3Os8i1aQ7M=;
 b=j9QA6T+jA3JcF6JVeZBCQnCgDBJU9LEt8T+5faACQOoiZzR6SEaheFckX9EXrAqJOvNWgD9qot9sYyVV6MOqVdgxTYcKdiI/vg55j7EMXAl/gxBkUwL87btmmCNkw6Wv2PzvJiKtPbDZnuhlQpFHAzH7KCmVzYzsdfdPBz3Jm76dO3xxifoLNmxM9cccwKnaMbRqmtQOy7IMwxKcggUApQihVqeTdYabW/ar9nXvmIOph3mrzPUGYa2JOnX7QBMQCW12t3s7DO4XtgNwYem5nvOo0iB2ItI0IgurCQ1308eifvX39efI7emD28sFWDgPiJm9bc+ifFQKA8ohNRkkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMyvSnUNWTvCa19IAQvR1yIaFsif3911D3Os8i1aQ7M=;
 b=Zbf+2EOPrbtz9Shyp16Ppi14+EchLqbJrazxnnh7oXVZmlnkhoMXUpMEBgF8bgDyoDA86qtl9l49DsJmrLZWcXb4OYndVB+esu7XusKU39E5lYDUY9PpnwhVNA2YU7zuSdHclbT8CdwRT29NT3hzPzxyd3Q08eup2Ed/Zqe2rvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 10:33:45 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff%4]) with mapi id 15.20.6455.024; Tue, 6 Jun 2023
 10:33:45 +0000
Message-ID: <1a56856b-6b53-732b-4740-5556c980a785@amd.com>
Date: Tue, 6 Jun 2023 12:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: add option params to enforce process
 isolation between graphics and compute
Content-Language: en-US
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601111441.1088083-1-chongli2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230601111441.1088083-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8dd450-a89a-454f-fbc0-08db6679812a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgEFeqgVupkbEGUC8R+i+Vj+7syTgmOHm6nfM2/B3nPeAaZBT3tN2aIUpp9Hcl+NpCp3YwhrY3SXSi/tDtB2pu74Yuwq2+uP3+EAN0uy1ZkOgiNnjkTmc9Y7QzPs9TSJKNkfzFtIe7YEHssoRaV7MXHEP893qtqwJ2Z8AivOD4qa3QUG8PAdqcB3TCbmtveGeU2O5E8ADascx5wsYk/XS/JxHAL4z13vVEp4qI3BPruYEx9wX6Ti6Pe0ko0Cnj3lNvuNbYZks5XZgTsdl2qWrnon5aze6T6yshz1IrPKFPQ8Hc+K0raiONn58SMVKySP45pvr8JP8qJwCTAXMyFoY8ElP6YFdR+owiBez2um6gc39eRY8iMmUVf5L17UfBQt/x1JLio6jvP+X2eyKK5K8biCiHSxm9Bjlge+qix7s0uxTgVWqR/hZxEP7a26aJ8wk9qzwxSeGnhM8ua4ghehqeAbBkkz7Hfe0J0vg5QlHIQ2RmFwqgZrGVuGCTJaI6TedAoXw99A0k1COiGg5S369MRX9JZZlnA4z2ek+jpKmp9b75t8RiQChiA962HEFl5TdyRvRy9WmWHYSq2/6DgS918JhRSFxPHnn8ke1UdGd4xA/ugy3i9tql75purXv+K5bcxL54yatk1bCz3JZIrIDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(83380400001)(478600001)(8676002)(8936002)(316002)(4326008)(66946007)(66556008)(66476007)(5660300002)(31696002)(38100700002)(41300700001)(86362001)(6486002)(36756003)(6666004)(2906002)(6512007)(186003)(6506007)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmF2VWJQR2RRRnBzWU45MStiOWU5UzQ1WnVLSmtyTm5NTGpqenhIQ1BsWERK?=
 =?utf-8?B?WGdlYWV3SHdMeXczeDhOcEd1cTRHTDBhbi9wd0J5UWNkbk16Ymh3NGNsdnY2?=
 =?utf-8?B?bks3WWJnZGRSdlQrellJT0Y3UFdVNi9rZmhCMm5mVjI1NWQwK2twOW05bk02?=
 =?utf-8?B?SFVndDFzUUxLSkxIZ2ZsbGJQcStWb2JzZ1VxWTNrRTdZVmY1N2hRYnBhMUk2?=
 =?utf-8?B?ekJHblhaelJXd0NQVmlxcFdOVVVUR2J2aWNQZmpQT0EwaEdCT2hObGVrWnBS?=
 =?utf-8?B?ZnJUY0pyQXl1dlBZWXdtdWdPMWhyREQ4d2FjR2ZzTVZHZ0hDUks5NENuYXQ0?=
 =?utf-8?B?MHFrT0E5QkhtRTNWMVhxTHNLVklBWnZpQnVxL1Q3dWVPa2RSZlVNaldoa0FD?=
 =?utf-8?B?R2VxNDJieTNtWlFxVUwwTkNxUXM3NDNRQjAvdUpXTzdCWHV3Sm5TNDNmaHM5?=
 =?utf-8?B?UkZpRTNyZ2xidlZ0S05iUmVVY2dTZ1YvZnpzem9zdm42RVk2K3I0ZmFuOHNX?=
 =?utf-8?B?WGRjdllYdkNJblNyQWgrcXBDMGx1bW5sRTQ3bzk4KzRqS21PUnNnaVV2UWlT?=
 =?utf-8?B?UkFwTGFBUnJ0WTdseVBHbGtPMjgyYVVUVHFobTBobHNkM1ZxdklJOFVFQ2pZ?=
 =?utf-8?B?eEJLRytRWHVabnN6V1dxZ1RaUVUxN2p1WWxVZnBJTHU0TVlLaGpDTGVkb0Rp?=
 =?utf-8?B?c1ZKMXJnTldCbEkwVzBST3dwWW9Tdi8reTh3UTRtMzNzdWlwSXBuN2tTMW5t?=
 =?utf-8?B?WjV0bTN1SVpqeStacTA3eFFRY3N4dE9DWldCRTF1L1VlU3VPdEZrU3llZzQx?=
 =?utf-8?B?SjF2SkNZSjBodDZLeEZLQk0xdTVacjZUaTdGdWp0RmJLQUxoN2tUbnVQa2dU?=
 =?utf-8?B?VmJPK0NuZTA0VHliY0JhTXFIQnlLVzU2d01qWVdHYU1nUGVEM2s0LzMrd2xx?=
 =?utf-8?B?SzJhNDcwMWRmTVliZ2djKzFGNkFzZlRQdmpQbkRjL0ZvcWtsMitQTC90NWZW?=
 =?utf-8?B?ZUU1NUQ3UmpRRHVSb2Fjd1E4cjNXanE5cGFPWWU1TTBFSnFrOE0rWGtvOEo3?=
 =?utf-8?B?NHc0KzFwWXpuRENFUStlME03WUhSRUxvbm9jSEx4ZnRndkJFbjhhQS9nTFFq?=
 =?utf-8?B?RElidkZaYmFMRyswWDQyL0NLU0FGcmZwWmFiMlVPSkx2YXBxUjdUMXMyc1cy?=
 =?utf-8?B?ZFpzMGJ4SWRPbm0yWEJHaFB1cWZzZ3JxMGZVZkhIQ1puV2tjTU5wL3lWN01m?=
 =?utf-8?B?dmJBQmtpUHEzNkwzOFhwVlhGVzdHdUwybkJnanUvYXZqSjYzQWs1RFIzV05K?=
 =?utf-8?B?VjdjUDQ5WUkxNDdVNlB3a3VobUJMMVpEZVRsVm5PTis2bDhGRFYxQjZpelBo?=
 =?utf-8?B?a2hHSkQ1a1RmdnlGTjlLOXBlN0lPbzdZSHBmR3ZrUlBBUUhIVk5TNUpKU2pL?=
 =?utf-8?B?M2FxOUpYSERUYWVQdE5kcnhVL0ppUEszeGQxd0l3d254RmVkOGlxUjdiYWxW?=
 =?utf-8?B?b3QrNzZ2ajJkT1dHU0U0bVV6VkdISjBjSlB3WjNidHVIb2VQQXFndXkrZitY?=
 =?utf-8?B?cnhpeDUybTVwckh4TVRpR2gwck0rQ2N1VVVkOEJBemxOYUVTYlJIekdMcHhE?=
 =?utf-8?B?M0taK1JVcDNOWkF6M29YZUhqZSs0Q0h2WHVwUGJTTHJnYk9IcHRWeVRjRjNF?=
 =?utf-8?B?UVZnc0tZVFNLR2NtblROczVaTkJxRW01MTZ4SGRGZDNnd1lWTVZKeE8wZDVM?=
 =?utf-8?B?aTBPTVY5Z0lka1dMWFB1ZUQyY3Y5UXZHb0gxQkRqRmhXamU2b20xUzQzTVBL?=
 =?utf-8?B?azk1MmJSS2Y3NzBuZnJEM25CTk9QTlJtdmdaTUE0T1VHemRJcWhZL0pvZTBl?=
 =?utf-8?B?YXU3MjVBRmtua3RxNEd5Y2grWW5JMVVOWEhFZlhZR3YweE5LS0lBeEJEWmw5?=
 =?utf-8?B?YldwU0U5TVBPWE9wQnA5ZVhBUEpSbnNERU1yTGVkbFdxa2JzTXJMdU82Q1Ey?=
 =?utf-8?B?ZWorUEt1bTZrTnl1alBVeHJjUkpDVU5VTXpYUzJGMkl4cFk2SXJuckZMVHB5?=
 =?utf-8?B?UTZScVRkalY4OE5ubnE2S1dhQVdWVTFaVUNJN0N5NGxLR0syTVZ2QkF6ZDdK?=
 =?utf-8?B?Z0JNZmdCL0NONjkydVZraUZCcFArWFhaRWFtNjhrR2FaRHV2OXlVeG8vYUd3?=
 =?utf-8?Q?aGqfCuiRgDYXSTnwR0TPPQVLlrHpv6BofXvQqimfwYFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8dd450-a89a-454f-fbc0-08db6679812a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:33:45.0766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEl3+/jbLS4sTk0MgehvJsWnfZA96V8+4/mfNmmvyl17Dujls3fK3fRKA5ioOwIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
Cc: zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.23 um 13:14 schrieb Chong Li:
> enforce process isolation between graphics and compute via using the same reserved vmid.
>
> Signed-off-by: Chong Li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 13 ++++++++++++-
>   3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ce196badf42d..48c5c547d85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -215,6 +215,7 @@ extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
>   extern int amdgpu_use_xgmi_p2p;
>   extern int amdgpu_mtype_local;
> +extern int enforce_isolation;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..2e0ebd92b4cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -973,6 +973,15 @@ MODULE_PARM_DESC(
>   						4 = AMDGPU_CPX_PARTITION_MODE)");
>   module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>   
> +
> +/**
> + * DOC: enforce_isolation (int)
> + * enforce process isolation between graphics and compute via using the same reserved vmid.
> + */
> +int enforce_isolation = 0;

Please move that to the other declarations above.

> +module_param(enforce_isolation, int, 0444);

IIRC you can also use bool here.

> +MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . 1 = On, 0 = Off");

This way you can drop the "1 = On, 0 = Off" part from the description 
because "enforce_isolation=on" should then be accepted on the kernel 
commandline as well.

> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index c991ca0b7a1c..33efa17d08ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -409,7 +409,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	if (r || !idle)
>   		goto error;
>   
> -	if (vm->reserved_vmid[vmhub]) {
> +	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
>   		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>   		if (r || !id)
>   			goto error;
> @@ -578,6 +578,17 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>   		}
>   	}
> +
> +	if (enforce_isolation) {
> +		struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
> +		struct amdgpu_vmid *id = NULL;

Empty line between declaration and code please.

> +		++id_mgr->reserved_use_count;
> +		id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid,
> +					list);
> +		/* Remove from normal round robin handling */
> +		list_del_init(&id->list);
> +		id_mgr->reserved = id;

It would be good if we don't duplicate this hunk here and in 
amdgpu_vmid_alloc_reserved().

We should probably cleanup amdgpu_vmid_alloc_reserved() a bit and move 
the check for vm->reserved_vmid into amdgpu_vm_ioctl().

This way we could call amdgpu_vmid_alloc_reserved() here as well.

Apart from that looks good from the technical side.

Regards,
Christian.

> +	}
>   }
>   
>   /**

