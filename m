Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A322ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 13:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E6510E927;
	Wed, 21 Sep 2022 13:01:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFB310E3EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 13:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7GnyG2m7tP/7vKgdnAbWH7MnbF2Qw7brTNf6qOVcx5jEjd/+rdEKKi3/r3M+QQmAX6AE+deSj7XSqbY+Hu5YS+MTWx2gyZ0egScZuDIcCptnnvn2es2443u2pIcS/4TpOQYOFq3FpWajfoDl2E0yZKWur7yrRkkxobEbyjOJ+2QsAWMyl+HfHnwiVS2nD0Zfm+2ln+Ll0gIAMprW/hiKbVWaANu5eXkQ8Q6E6z52xHl2ZvK4Dalgq45a0YphxgVV6wtTvEasVmGQgFIa/BmFvOPGVu/aJR4kH4GtOKKxZ4euJ57EV2JXDkmW5eX9+5YKSTxwDRTYr4H4IskW3PiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb8zYaHsz51t+Yovfe9msgbp1ndgj9KkEsT1tvtfRic=;
 b=KynhblkMNBGRAGzwZAsGzH2OPDZvbUHq6uipyrtQemCjrGjRUMoVA5i6LleyQWJKF3/ius4wCrLImihDXunwX1yJlkliY3O5GzSOWnSCqIlwAWPeqQ+R4j2+n7DRPPxQAMcWeqIkuJDrSMj/3yhHWzv7v/WXGDkDKTK5/8KocRWjudu/hRWhr1yrfjfdlTiYS8fhx7OptIGxvYSviSsk5sMRKobX9++Ia0m19g9lCyaikZLVX6tl+zqGlEh+EpBxvognXVk8e2/7I8T8g5RNiOQWSuFP7oebJ1Oer11pd5w0CL2js0djNzM6kyKDftBolYRzfeAdApYR0xrpK4V9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb8zYaHsz51t+Yovfe9msgbp1ndgj9KkEsT1tvtfRic=;
 b=Gs2gr97Gtzhyn0dcEk5peeR19skCXo2A8Hs2VBmUw4NZ/CApDA0pqfQ+Bd1ntdh4aGPINo1GGGWbmcKg3H6swofuHEKxgNy1YJrHSNNow3WrN+EhDNzz0c4ZmcHJR63YnmkM9zU9yzhFITEuJBGxin9vEaEHi8MpbFDiwA0k9mA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 13:01:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 13:01:17 +0000
Message-ID: <14ab09ae-0a80-1702-f446-4fc32681ff8c@amd.com>
Date: Wed, 21 Sep 2022 15:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-4-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220921094117.1071106-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7d9392-7425-41af-de0e-08da9bd15f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cAOrUdOZRwHV7DW9M41hiHxwQWKlSlrnk/Hdf94AEJ0rmc2JRKr/ZVB7rsDe9dD3MTgAoVAyyt3McZuJSiYehgExA+J/71U9RLBv3730RvZUuXxzwWb3ODFiPOe41e3t5tV/gDM2yPoGhbhalVRW9HXZdLFBPWH7Lpi62l882xhhfuMCZLGJ71Qoo0K1thVEhYhg7Jwg71K7n78UOza+XyoIZhMqfgLKCXu7CkBxy7Bm5Glp93fcBjKt1AN+G0HZbnt/fx6ZlCEaT26aBdZd27zGqLgYvbaT43efAtGLqUyzbUAa51fVqRMMqivSbi5srib65UQLLLldgPhM6hIqApzRLqe4qIS+kR7uVV2KvlPdzvOhNZPNceC1O5UM2ZwYuAod3lmMuP0RIsjpERP6iG8+5VN8/6AjhuyktjEUQNBAV3BshIqRkk8KfW9GGlrASEGjdzexepdCfrp84MRKTr0W64a/Umy7BSAde9Z5Ppg8aae/uUEOs2OU/tgoD+lb6AVyD92yPITHc9HqbE3Bj5q+0zbvxLDYusI0Vx/QG2V/vzNQHWGmlJFQ/JtPIPQNpbC7Nwqy01RbnRGsLivkao7WHFeMV6fEk3F5hcmc/vuukypblCJ+AHUG/trTU6WJN5/pJ5YP+b832SE+DXrIVw417lNkjtUVR8naowdU2Py6oQGqj2dzRaFS5BatC/79kMCJeEkkU0RamqfgFfhnDAwE6zNhpuhMtpBneHZJ7VhYYGn836LwSI00FzbPBIKL04TrrHbaqm+D2mFMzmOTpgB+ZaeG4CziSIn2qQjDcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(6506007)(83380400001)(316002)(38100700002)(31696002)(4326008)(41300700001)(6666004)(54906003)(8676002)(6512007)(186003)(36756003)(86362001)(66556008)(66476007)(8936002)(2616005)(2906002)(66946007)(5660300002)(478600001)(66899012)(31686004)(6486002)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU81cTVFUkVBYVl5WFFQMFlKYU1LVXZLTVpsUkYvalZyZmx1ZFhxMTB4ditQ?=
 =?utf-8?B?QlZncFg1cTRxWFBWeHlFeXYwRkRXT1RIcE1PQWpGbUM2QStLUDZsQlpUTmRL?=
 =?utf-8?B?TUJSM0pnNjNmWm9oUEpmME5UL25IMEFoWWdRMkdmcStlc2RUcTRMWDdsWnFV?=
 =?utf-8?B?OUs1N1ZzWUQyOWFqckhveWlvcVdXZGw0RUpYdlcyWWRQNzh4eFFKdUM5SW1n?=
 =?utf-8?B?eXdYbnFKR3BrNGVzZ1lTcS9OQnZSVytPUFdTbE8zemNNRGlPQTV0aHdPZXBE?=
 =?utf-8?B?UDl5Sm1ucDh3d21ZbXoyZGh3TGx3Z3NpR2xqSFpxNkJEdDQwZm5MN216djJ0?=
 =?utf-8?B?ZHZvMCtUWklJdXhYMzJlbGplM1VDUS9FRWJMMW9WNnVDV3RTSCtRaE1yV2tM?=
 =?utf-8?B?enc5b2dyNDlQU1FJNEFVSCs4UHJDMDFaN1pjbXJpVVNOZWdDMnJKcGtPRFRD?=
 =?utf-8?B?Q1FCcDJqaUFjVFJXYkYxSmhwUkY5YlJwdUluRkpNM1RXdUdpdEVhd1pIUTkw?=
 =?utf-8?B?aDg2S3hJRGtqMnZIWit4N3F4ZnljZUltRml3N20ySGZ6cFQwRGZMeFBPWjJ1?=
 =?utf-8?B?SmhWMFA1TWlxTXd6eGx5WlRPb2MvRVNHWkNTN2tob0Y5cDdjaVdYQ1ltSUFD?=
 =?utf-8?B?a29yZzh4Vm1kWFNBcUZBTFZ5UEVaMCtiaGtPTUNydGxtVHMwdnRycGlPUlRj?=
 =?utf-8?B?N3BoQ1VMVWJYM1FveE9nRzhPanlVVzJ4d0kvSmhjNmdVVHlRRXJ3Yk1yTDNS?=
 =?utf-8?B?dzVaN0p3a213a05RMkhRYWs0OUlqMktUVy9ySmZtcjVxbVp6bjA4T0NpWDdG?=
 =?utf-8?B?ejQrK2h6dExmTUVCdGp6YVlaUzdXNklsdXVqNy90ZTM3eFgxc0VKOUdWRlRL?=
 =?utf-8?B?ZStqMjZITGtPRVc2MjhtRzBsdlZWYXVqdExQUmJlbWlMbTk2d3VMN0FISkVs?=
 =?utf-8?B?Ly96azZGVEpxd0taOEt2WW42amVBMmdlR1hwL1hURURPNGtsUDNJM3hlUFdR?=
 =?utf-8?B?NmhKQzIrWGRNN3JSMUx2V1ZCNmhNTGY0eWlwODVoTEZ4dkhmRHhXUHB2OHVJ?=
 =?utf-8?B?cmwwcjdTaGJHTFUxMDl2TFlBUVNpZytrRVlsVEw2dnJnNjhYUlhwVTV2Nmcx?=
 =?utf-8?B?Y1pCR1Z0V3dpT0trMFZmL1l1V3FFZGg4UmJDMGtiMkxYdWtUZlBsWDYxNXF2?=
 =?utf-8?B?TG1oYytOeTkwZ1Fydi9CNlc3bFZCUUZzbW5wT0lPcHBhclZHRW9OelhidWdm?=
 =?utf-8?B?VyswZ2EvS2xoTnpNOXJyNUkxczVLZjhzMS9YY3dLU29rd0RvWlRKbllxTGRF?=
 =?utf-8?B?Nm9DUHRlQXRFbWZSRzVSTC9JS09HckM0VndXMUl6dkxrazhzaEhqUmxhc3ZQ?=
 =?utf-8?B?MTYwL2xIdmgxNEYvcjFBUmtZa0VJamVHTU5pVklZY2VmNDhmRmQwZ3pBSkNZ?=
 =?utf-8?B?eisxRHRRY2pQSzJwNzV0REI0MVIwQktoTnNNUHdpL29NWENjMlNwQXVMYXpI?=
 =?utf-8?B?WGwyM0cyOGFtZGk1dXgxb3hkc3JoalFaaW9KaDZhSGpBOTd6RGR2VTAwdnN5?=
 =?utf-8?B?Z0MxekR4a21YdXljL1c1SGNRV1lBZis1VlNCR05NZDFhNFk5Rm95NUhCOWhv?=
 =?utf-8?B?TXhwSWRNWExCbUhnbm9GaVJYL1BzVnR3MXlVSy92TkQ4ckRsYXo5NjlzVk5l?=
 =?utf-8?B?dWZKQ3NVMUJjbEJBbTJXeGVtZVE4UXVYRTI1b09NY3NPMVA5Qm12T09mdTVU?=
 =?utf-8?B?a1RESEJDTVlxRUlVN0Y0Ymt3RGZLWFQxQ0s1S0ViV3poaE43aGZmSVRNTFFn?=
 =?utf-8?B?a010dUgxejBEaWc3UGt4S1lvTG9nak40YWs4SU5jSDdPWGRVWFY3Z2doZHN2?=
 =?utf-8?B?b1k3TS80dmpCbURGT2RKUWE1SXJhc0xkNkg0TXdXNjc3M1NkWG5DMkpyRGNG?=
 =?utf-8?B?U25oMWJpUFg3NlkzSHp6R0Y5R25LbkV1TTRMTldWZVd0dE14Y2FVYU5PZCsr?=
 =?utf-8?B?RDhzY2poVC9vSWViZ2M2Zll4Uk95VEpmdlNodnB1NGhkS3A5VjVyZnhqUkk4?=
 =?utf-8?B?dzhwZUhOekJ2aGN4cmhKaDFHbUU3NnBqc3Z4UVZaVEFHNllFZmVJbHNJMUFL?=
 =?utf-8?B?K1gzS2VUbVlYMHdTY0NZSzU2b3FlbnpyQXdpblAydUgvR01haWNyaE9KRTM5?=
 =?utf-8?Q?2yLrV0ciy86Y+ylNIMEU1oM2sL8Y6FY+iSHmSAtIripb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d9392-7425-41af-de0e-08da9bd15f10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 13:01:17.4726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOML4rZ5RiIEQUwPWB8Q2++2sICuIN4McbLuiRZn7SmYrFqOPrLeC2MtGb4rUb3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Trigger Mid-Command Buffer Preemption according to the priority of the software
> rings and the hw fence signalling condition.
>
> The muxer saves the locations of the indirect buffer frames from the software
> ring together with the fence sequence number in its fifo queue, and pops out
> those records when the fences are signalled. The locations are used to resubmit
> packages in preemption scenarios by coping the chunks from the software ring.

Maybe change the subject a bit. The MCBP is not really triggered by the 
core Linux kernel.

Maybe write instead "MCBP based on DRM scheduler".

>
> v2: Update comment style.
> v3: Fix conflict caused by previous modifications.
> v4: Remove unnecessary prints.
> v5: Fix corner cases for resubmission cases.
>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     |  91 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 186 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  24 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  27 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>   10 files changed, 372 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 85224bc81ce5..24c5aa19bbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_sw_ring.o amdgpu_ring_mux.o
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o

This functionality is spread over to many files. Probably better to move 
this into the amdgpu_ring_mux.c as well.

>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 258cffe3c06a..af86d87e2f3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		}
>   	}
>   
> +	amdgpu_ring_ib_begin(ring);
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>   		ring->funcs->emit_wave_limit(ring, false);
>   
> +	amdgpu_ring_ib_end(ring);
>   	amdgpu_ring_commit(ring);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> new file mode 100644
> index 000000000000..121b1a4e0f04
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> @@ -0,0 +1,91 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <drm/gpu_scheduler.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_mcbp.h"
> +#include "amdgpu_ring.h"
> +
> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_ring *ring = NULL;
> +	int i;
> +
> +	spin_lock(&mux->lock);
> +
> +	amdgpu_ring_preempt_ib(mux->real_ring);
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			ring = e->ring;
> +			break;
> +		}
> +	}
> +
> +	if (!ring) {
> +		DRM_ERROR("cannot find low priority ring\n");
> +		spin_unlock(&mux->lock);
> +		return -ENOENT;
> +	}
> +
> +	amdgpu_fence_process(ring);

That's usually and extremely bad idea since fence processing should only 
be kicked of from the interrupt handler.

Otherwise you have interrupt handler and this thread here racing to 
signaling fences.

> +
> +	if (atomic_read(&ring->fence_drv.last_seq) !=
> +	    ring->fence_drv.sync_seq) {
> +		mux->s_resubmit = true;
> +		mux->seq_no_resubmit = ring->fence_drv.sync_seq;

Don't touch any fence handling internals here. If you need to know which 
fences are signaled and which aren't look into amdgpu_fence.c

> +		amdgpu_ring_mux_schedule_resubmit(mux);
> +	}
> +
> +	spin_unlock(&mux->lock);
> +	return 0;
> +}
> +
> +/*scan on low prio rings to have unsignaled fence and high ring has no fence.*/

What exactly should that comment mean?

> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_ring *ring;
> +	uint32_t seq, last_seq;
> +	int i, need_preempt;
> +
> +	need_preempt = 0;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		ring = mux->ring_entry[i].ring;
> +		last_seq = atomic_read(&ring->fence_drv.last_seq);
> +		seq = READ_ONCE(ring->fence_drv.sync_seq);
> +		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			return 0;
> +		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			need_preempt = 1;
> +	}
> +	return need_preempt && !mux->s_resubmit;

Well what exactly are you trying to do here? Finding if a lower priority 
ring has unsignaled fences?

Regards,
Christian.

> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
> new file mode 100644
> index 000000000000..0033bcba8d03
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_MCBP_H__
> +#define __AMDGPU_MCBP_H__
> +
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux);
> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux);
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 4eaf3bd332f7..94362c39b73e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -574,3 +574,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
>   
>   	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>   }
> +
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_begin(ring);
> +}
> +
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_end(ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index aeb48cc3666c..36726c28a806 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -312,6 +312,9 @@ struct amdgpu_ring {
>   #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>   
>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
> +
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index d6b30db27104..70dd725432d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -24,30 +24,59 @@
>   #include <drm/drm_print.h>
>   
>   #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>   #include "amdgpu_ring.h"
>   
>   #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
>   
> +static struct kmem_cache *amdgpu_mux_chunk_slab;
> +
>   static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>   				  u64 s_start, u64 s_end);
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux, bool is_fallback);
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
>   
>   int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>   			 unsigned int entry_size)
>   {
>   	mux->real_ring = ring;
>   	mux->num_ring_entries = 0;
> +
>   	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>   	if (!mux->ring_entry)
>   		return -ENOMEM;
>   
>   	mux->ring_entry_size = entry_size;
> +	mux->s_resubmit = false;
> +
> +	amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
> +						  sizeof(struct amdgpu_mux_chunk), 0,
> +						  SLAB_HWCACHE_ALIGN, NULL);
> +	if (!amdgpu_mux_chunk_slab) {
> +		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
> +		return -ENOMEM;
> +	}
> +
>   	spin_lock_init(&mux->lock);
> +	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
>   
>   	return 0;
>   }
>   
>   void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>   {
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *chunk2;
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		}
> +	}
> +	kmem_cache_destroy(amdgpu_mux_chunk_slab);
>   	kfree(mux->ring_entry);
>   	mux->ring_entry = NULL;
>   	mux->num_ring_entries = 0;
> @@ -67,6 +96,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   	ring->entry_index = mux->num_ring_entries;
>   	e->ring = ring;
>   
> +	INIT_LIST_HEAD(&e->list);
>   	mux->num_ring_entries += 1;
>   	return 0;
>   }
> @@ -82,6 +112,9 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   {
>   	struct amdgpu_mux_entry *e;
>   
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
> +		amdgpu_mux_resubmit_chunks(mux, false);
> +
>   	e = amdgpu_get_sw_entry(mux, ring);
>   	if (!e) {
>   		DRM_ERROR("cannot find entry for sw ring\n");
> @@ -90,13 +123,19 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   
>   	spin_lock(&mux->lock);
>   	e->sw_cptr = e->sw_wptr;
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
> +		e->sw_cptr = mux->wptr_resubmit;
>   	e->sw_wptr = wptr;
>   	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>   
> -	copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> -	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> -	amdgpu_ring_commit(mux->real_ring);
> -
> +	/* donnot copy the ibs which have been resubmitted*/
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
> +		copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +		amdgpu_ring_commit(mux->real_ring);
> +	} else {
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	}
>   	spin_unlock(&mux->lock);
>   }
>   
> @@ -159,7 +198,7 @@ u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>   	return e->sw_rptr;
>   }
>   
> -/* copy packages on sw ring range[begin, end) */
> +/* copy packages on sw ring range[start, end) */
>   static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>   				  u64 s_start, u64 s_end)
>   {
> @@ -183,3 +222,140 @@ static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>   		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>   	}
>   }
> +
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
> +{
> +	mod_timer(&mux->resubmit_timer, jiffies + AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
> +}
> +
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	amdgpu_mux_resubmit_chunks(mux, false);
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
> +	if (!chunk) {
> +		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
> +		return;
> +	}
> +
> +	chunk->start = ring->wptr;
> +	list_add_tail(&chunk->entry, &e->list);
> +}
> +
> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	uint32_t last_seq, size = 0;
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *tmp;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&ring->fence_drv.last_seq);
> +
> +	list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
> +		if (chunk->sync_seq <= last_seq) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		} else {
> +			size++;
> +		}
> +	}
> +}
> +
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
> +	if (!chunk) {
> +		DRM_ERROR("cannot find chunk!\n");
> +		return;
> +	}
> +
> +	chunk->end = ring->wptr;
> +	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
> +
> +	scan_and_remove_signaled_chunk(mux, ring);
> +}
> +
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux, bool is_fallback)
> +{
> +	struct amdgpu_mux_entry *e = NULL;
> +	struct amdgpu_mux_chunk *chunk;
> +	uint32_t seq, last_seq;
> +	int i;
> +
> +	if (is_fallback) {
> +		if (!spin_trylock(&mux->lock)) {
> +			amdgpu_ring_mux_schedule_resubmit(mux);
> +			DRM_ERROR("reschedule resubmit\n");
> +			return;
> +		}
> +	} else {
> +		spin_lock(&mux->lock);
> +	}
> +
> +	/*find low priority entries:*/
> +	if (!mux->s_resubmit) {
> +		spin_unlock(&mux->lock);
> +		return;
> +	}
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			e = &mux->ring_entry[i];
> +			break;
> +		}
> +	}
> +
> +	if (!e) {
> +		DRM_ERROR("%s no low priority ring found\n", __func__);
> +		spin_unlock(&mux->lock);
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&e->ring->fence_drv.last_seq);
> +	seq = mux->seq_no_resubmit;
> +	if (last_seq < seq) {
> +		/*resubmit all the fences between (last_seq, seq]*/
> +		list_for_each_entry(chunk, &e->list, entry) {
> +			if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
> +				copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
> +				mux->wptr_resubmit = chunk->end;
> +				amdgpu_ring_commit(mux->real_ring);
> +			}
> +		}
> +	}
> +
> +	del_timer(&mux->resubmit_timer);
> +	mux->s_resubmit = false;
> +	spin_unlock(&mux->lock);
> +}
> +
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
> +{
> +	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
> +
> +	DRM_INFO("calling %s\n", __func__);
> +	amdgpu_mux_resubmit_chunks(mux, true);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> index e8ee34e6b9a5..f6fc0afa3cc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -35,6 +35,7 @@ struct amdgpu_ring;
>    * sw_cptr -- the position of the copy pointer in the sw ring
>    * sw_rptr -- the read pointer in software ring
>    * sw_wptr -- the write pointer in software ring
> + * list -- list head for amdgpu_mux_chunk
>    */
>   struct amdgpu_mux_entry {
>   	struct                  amdgpu_ring *ring;
> @@ -43,6 +44,7 @@ struct amdgpu_mux_entry {
>   	u64                     sw_cptr;
>   	u64                     sw_rptr;
>   	u64                     sw_wptr;
> +	struct list_head        list;
>   };
>   
>   struct amdgpu_ring_mux {
> @@ -53,6 +55,24 @@ struct amdgpu_ring_mux {
>   	unsigned int            ring_entry_size;
>   	/*the lock for copy data from different software rings*/
>   	spinlock_t              lock;
> +	bool                    s_resubmit;
> +	uint32_t                seq_no_resubmit;
> +	u64                     wptr_resubmit;
> +	struct timer_list       resubmit_timer;
> +};
> +
> +/*
> + * amdgpu_munx_chunk -- save the location of indirect buffer's package on softare rings
> + * entry -- the list entry.
> + * sync_seq -- the fence seqno related with the saved IB.
> + * start -- start location on the software ring.
> + * end -- end location on the software ring.
> + */
> +struct amdgpu_mux_chunk {
> +	struct list_head        entry;
> +	uint32_t                sync_seq;
> +	u64                     start;
> +	u64                     end;
>   };
>   
>   int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> @@ -63,4 +83,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>   u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>   
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> index ec50793aa54d..4809ecf76180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -26,6 +26,7 @@
>   
>   #include "amdgpu_sw_ring.h"
>   #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>   
>   u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>   {
> @@ -58,3 +59,29 @@ void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>   	WARN_ON(!ring->is_sw_ring);
>   	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>   }
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
> +		if (amdgpu_mcbp_scan(mux) > 0)
> +			amdgpu_mcbp_trigger_preempt(mux);
> +		return;
> +	}
> +
> +	amdgpu_ring_mux_start_ib(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +		return;
> +	amdgpu_ring_mux_end_ib(mux, ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..b7e94553f4fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>   		return 0;
>   
> +	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> @@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_ring_emit_switch_buffer(ring);
>   		amdgpu_ring_emit_switch_buffer(ring);
>   	}
> +	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   

