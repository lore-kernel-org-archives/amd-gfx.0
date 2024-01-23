Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F955C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 09:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB87510E180;
	Tue, 23 Jan 2024 09:01:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5555C10E158
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 09:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMrs9yA5g6l1cSeEFAmcvL3b/tan/2Xh/ytf9b6Jyii5g/0XpNlbyrk/rUzBpW/4GVsOqDUklnLA660wTJYm1cKUHRZMtVfF4Pqv1xXey6dtqEIoMmGS5ZO/V/ImtATl+gihjMup420bvqcFIlGpd0i8aNGDul3OXcbo+72mMHAag5g75lKCvH2xhPPcE8ZnNcsaHlmYDO0IUM952pbgjGjxLSjSRGmwsEpiOeYyGVV9ykOhL/uixAfDN3VJ7lozrjYT82UZVeQcfp721kpb7M8e3Rwdz1AMuEUe/qt/58CBkYz+CPonGFEjuwaOXVpH+Rb+kKoxDRL0MlDZgch8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXhVdl4r20r4ChEL+RDMklbKLF1YLeABBPs2OyfUKtg=;
 b=AUSUy0o7vzR9LQTKEKkzK3Uu4n5mxUK2CX9ZvzAoRm+awSoD9cGpwEJ/hUxUfpvQaM63sniViRwycmVuHRw0r+T8/wy694GivpXwQQL4EcsZ2i5VsNTHqpjA3jmP/XzEliwEfoScIJAhUECZKc9yoKCLecWizr2elwYrETXEUPzPNI7c061+5A0pa+qJMzRRa4xvAVKuFTEPmRk5uooGXUi1ZVk6E2oxvK4Zdc0BzNsisD++N7csfGaqSoLqAulXtFdzfyA9dWZPoM9mLSgpQvJFtuMa1WuO5AlrD85OH2Zu5TWb5OkSyNlFgCv9gNhDFs9+C+tOkovEyHxYY91eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXhVdl4r20r4ChEL+RDMklbKLF1YLeABBPs2OyfUKtg=;
 b=ZdWPIT9YPUrKE+Djt4/wn+JFljUcdtwkLfLIU+P7P5QrAjOvR+G58z/l5+r+sylDW0SpjOKlWm54hxGH808Wmcwhs+PvKg8SXXQJSzux+R3BIP4ipczc4V3M3yLbU9HdRvTGSakE43NbB0ioBvXFt2ygKKSC4q+cAZOiwk2Cbno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:00:59 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:00:59 +0000
Message-ID: <a699ff21-2793-4880-bbfe-0c9bf5107eda@amd.com>
Date: Tue, 23 Jan 2024 14:30:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: check flag ring->no_scheduler before usage
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240121001951.75950-1-vitaly.prosyak@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240121001951.75950-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: d7774f66-ae71-4ef7-0be2-08dc1bf1d0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASTtEeV+3E0YYOCGyB/n0XJhcf2j9wNQnKom0d4pVx9XhCv77XA+dgDo7jEKO979kL4PC4ZV2BBdH7oIzqQ1N4xpYZXb5Kg0pPFFMqu5YkWbSQFBZiBdS2Zbw/fG4ZhH1mfyTrrXY8ABTi5Ln2rVKVI1Hhse3ESI6uM1N41n+s4fTvuptjXzehZ4wlBwySRxLioIzc5hq0erH/OpyOd12YhfS1+xalWBLA14x8cvdBhhL3/U1cdPyfJNl8gdUOytlSkN2RVOi3OpxcOgzOCPvVCvxz5J0ohAykjp493/undM++qC2fDWv0nZbJMUnE9zZfBUIsmmrQwKAzu1sJGF65iVng1hFLjAcjsLSygH6blqgvBfxaN8NHSqooyOrW7diG3nLbttGSiKVSDK49gHdpOLgquJ8pzp9+eDTbIHG615/ytnJpyIY+BKeNaK0rdJrQNIfa+S8nV5Q8sHzbQok73znaDVzF4EBNuyOWx9q6mTfm9DJO7gNWg9/u+KFBU1rmME90ZQot/Ay7Yp/csqFXkcC2qbwlwbZGr3t+ndZNyW9/Z/xXfH7aX2zjCXo2rzVy3ywXZSTJyLMfEnEMzAdIovxF/0oQ5JxK6oN6Ip9eKzg3YXgoAx/CMbSPNoBuZkntREWL1THWxp4HlFRdJHvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(26005)(478600001)(6486002)(966005)(2616005)(31686004)(6512007)(38100700002)(5660300002)(66556008)(2906002)(66476007)(86362001)(8676002)(31696002)(8936002)(36756003)(6636002)(316002)(66946007)(41300700001)(6506007)(6666004)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWhib0ZqS3pVUWJYbmhOUUoybS9Nd215MzJLTXlZY3J3QXJteGJuRTc5N1lK?=
 =?utf-8?B?eGI2S1dVa3RrMzI4T2xic2lFbXhpNjRWdUY4OHllOXk3TVFJT3laT2pYUVhY?=
 =?utf-8?B?R3pvNVMyR2xoS3l6Q2pZQWRjaUFod2hxd2hVaVJPd28vOGdLbFZ6ZTJwc0pq?=
 =?utf-8?B?WnZyN2c2cWZzWnpRQ0VFY0ZKNHZpeDdxQ2tQRFJ1cVNnK1NlM3k0bjZlanhD?=
 =?utf-8?B?YXU0bm5IbTQ4VS9uSWFrY2pSUG5KZE5UelE0QXVjVFVrcStFTGF2c1M3YXJN?=
 =?utf-8?B?SEFGYnBlMmlJWWFISzljb2FpdkhDY2ZlTzViUEM1amF4bWc2QzF4bDdNOFhV?=
 =?utf-8?B?SkU0RUhMdGN6S3l2Q3p2dHlXUFBJdCtkMmFLcDNocFptUTJ5ZThyTlFmcXMy?=
 =?utf-8?B?L2ZiVnc0UVhzc1RNTERpVktLbmVlUnJnVWM4bUFlK0loKytDYnNRTDhXQ1o4?=
 =?utf-8?B?azAxYmFCQ0c3WmlYcExtK3ljS2NQQWVJOTdYQ09ZajZUbFZQKzBTOWFGTERP?=
 =?utf-8?B?dFE5bDFLb3VScjBmMU9pVXh1WmxWWWxyOXRQNmVUUlE2WFd1UnViclk2Zzg0?=
 =?utf-8?B?UklnQjBoVjk5ckdRZlZ5UHQ5Uk5RSmN2MGhrQ1pxYVQ1SmlHd1c0L1NQR3FF?=
 =?utf-8?B?cm1ua2dXa1F2U3MxOU1TSit5cXExa0VNWlpVTjRIL2FNL280YXA5RjBaR3Fo?=
 =?utf-8?B?TEE0aW5QL3IrTVBkZFlwa0MvVkY1dDQwbDY1NkhVcCs2VWgyWTdHK3ZteGRu?=
 =?utf-8?B?ZVFzZk9sSHc2VGI2dDl5TnhtNTV0MHo5cXMzMzdGdkJBU3lTWFpsZE5oMCs1?=
 =?utf-8?B?MDYwSUc5Sjk4RldCcWpiTkx0cEF4TGFxRUx6S2dsQllmRjhLV080dVBQWjhW?=
 =?utf-8?B?Y3ZYZ1kxRTZDUWprR3ZjdXhEbStFWE8yeVhHZllaak54SU92MWRmc004MHBu?=
 =?utf-8?B?d0NUZHN1ckZZNFNrRkFGS2Q1djI1eERtZFJGSHRKcXU1OGRhb1g2YWszamFh?=
 =?utf-8?B?RVJhSEVoeHNqS2EwQTVsdlRYUU1iMUtmY2g3amV3Y04wVUF6L0tZaTQ4bjhk?=
 =?utf-8?B?aG9zNURVK3FhbVBMNkpPVlQ2aXo2WmpXZjM0bjhHallGMFlIQWowQmhFY0xB?=
 =?utf-8?B?aDBINTdCRTdqZWlZaWdBTHY4ZVJTSGlFc0h5b3JmVk5CZGpDTFNqaC9UMUhX?=
 =?utf-8?B?UytKR2RaMVJmVFJ1NkF0Ym9EOG9hY2JkQXQ1ZXE0UGRmVTVYR0FqM2d5OXVn?=
 =?utf-8?B?UkVsdU9ZZzNRUUFCeWc0RkVDakk1OGlnTGlZaTRaYTFMQzJvWksvRUhOVVZV?=
 =?utf-8?B?cm9KamZneXVaeEtUSElhNnVWeUhJcnNSN2R0UkNhL1NHdElPWWhqK2ZOMUdU?=
 =?utf-8?B?MUQyRmVrdm5rVFZwN25kdFowZEsrcHgzcDJQek1GRjI2cmdjY0paS3MrMjVa?=
 =?utf-8?B?OWtzTFBwQU5ucjR4WWtjek5Wb3pFdWRPQVN2VERYdGlNdmp2bGRVYnFNT1M3?=
 =?utf-8?B?S21YalJtbHBSZnBUN3Z1RTNVQVRGMkZyNURTdGZ5dituNDJJWktDcnFESXRD?=
 =?utf-8?B?a0hDZ1JBZ2VCYmp2ektMdDFFem9TYWtkc0tkYUx1RTZYS3pUNGxoVS9zMzJy?=
 =?utf-8?B?anlFWk5HWmJxaWZEQmlFQy8rN2orU0loaytadVIrV2NIc0JYWVI3MHhkSWRI?=
 =?utf-8?B?LzBUdkZmc29RMkJuQkpRSmltODc0VzdYek5rY2tjalA3MFZLQlhhZGhEakkr?=
 =?utf-8?B?a25ZTDdIVDNncmE3WEFJc0ZhOFNWQ2lkaitYQkN3VUV0aWVmVUhyRXhyWGVr?=
 =?utf-8?B?NGFndmtMdTJwRDVoNjhSUkVrNCtuUGwzdVRIN1JiclZhWFdZWld5dC9PS0l3?=
 =?utf-8?B?M1BRN1dGbDBqWTZkTnNBOEFnMVRza2hoQlNGbVl4ZjdsdEd2WkEzVFdnVGNy?=
 =?utf-8?B?d3dqNmFnUmtIeHkvUUV5MElsODdFTE15WGYydjVBQkw0LzBqY3hCOXA4RTlm?=
 =?utf-8?B?b1BISGIzMVYvaFduZEp6a3RRY3c1dDJndzNid1JPbUZSRkxKWkNqbzdzeGUw?=
 =?utf-8?B?UXdHTkZnYlR4MVhCNzJWamNMK3dYejQwR3hzdjV0RnVHTHQ1amhYMUw2TWMz?=
 =?utf-8?Q?uNMvPAg07LWIFR8JKtIWoP8BX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7774f66-ae71-4ef7-0be2-08dc1bf1d0f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:00:58.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py/BXeCw7VXgzKOuWCwDqRi0K101YMSmyoF5fQSH4XnyBvHQtNC3qZ+0TT2EmPBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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



On 1/21/2024 5:49 AM, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
>    The issue started to appear after the following commit
>  11b3b9f461c5c4f700f6c8da202fcc2fd6418e1f (scheduler to variable number
>  of run-queues). The scheduler flag ready (ring->sched.ready) could not be
>  used to validate multiple scenarios, for example, check job is running,
>  gpu_reset, PCI errors etc. The reason is that after GPU reset, the flag
>  is set to true unconditionally even for those rings with an uninitialized scheduler.
>  As a result, we called drm_sched_stop, drm_sched_start for the uninitialized
>  schedule and NULL pointer dereference is occured. For example, the following
>  occurs on Navi10 during GPU reset:
> 
>  [  354.231044] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>  [  354.239152] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>  [  354.246047] RIP: 0010:__flush_work.isra.0+0x23a/0x250
>  [  354.251110] Code: 8b 04 25 40 2e 03 00 48 89 44 24 40 48 8b 73 40 8b 4b 30 e9 f9 fe ff ff 40 30 f6 4c 8b 36 e9 37 fe ff ff 0f 0b e9 3a ff ff ff <0f> 0b e9 33 ff ff ff 66
>  66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>  [  354.269876] RSP: 0018:ffffb234c00e3c20 EFLAGS: 00010246
>  [  354.275121] RAX: 0000000000000011 RBX: ffff9796d9796de0 RCX: 0000000000000000
>  [  354.282271] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9796d9796de0
>  [  354.289420] RBP: ffff9796d9796de0 R08: ffff977780401940 R09: ffffffffa1a5c620
>  [  354.296570] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  [  354.303720] R13: 0000000000000001 R14: ffff9796d97905c8 R15: ffff9796d9790230
>  [  354.310868] FS:  0000000000000000(0000) GS:ffff97865f040000(0000) knlGS:0000000000000000
>  [  354.318963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>  [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>  [  354.331859] Call Trace:
>  [  354.334320]  <TASK>
>  [  354.336433]  ? __flush_work.isra.0+0x23a/0x250
>  [  354.340891]  ? __warn+0x81/0x130
>  [  354.344139]  ? __flush_work.isra.0+0x23a/0x250
>  [  354.348594]  ? report_bug+0x171/0x1a0
>  [  354.352279]  ? handle_bug+0x3c/0x80
>  [  354.355787]  ? exc_invalid_op+0x17/0x70
>  [  354.359635]  ? asm_exc_invalid_op+0x1a/0x20
>  [  354.363844]  ? __flush_work.isra.0+0x23a/0x250
>  [  354.368307]  ? srso_return_thunk+0x5/0x5f
>  [  354.372331]  ? srso_return_thunk+0x5/0x5f
>  [  354.376351]  ? desc_read_finalized_seq+0x1f/0x70
>  [  354.380982]  ? srso_return_thunk+0x5/0x5f
>  [  354.385011]  ? _prb_read_valid+0x20e/0x280
>  [  354.389130]  __cancel_work_timer+0xd3/0x160
>  [  354.393333]  drm_sched_stop+0x46/0x1f0 [gpu_sched]
>  [  354.398143]  amdgpu_device_gpu_recover+0x318/0xca0 [amdgpu]
>  [  354.403995]  ? __drm_err+0x1/0x70 [drm]
>  [  354.407884]  amdgpu_job_timedout+0x151/0x240 [amdgpu]
>  [  354.413279]  drm_sched_job_timedout+0x76/0x100 [gpu_sched]
>  [  354.418787]  process_one_work+0x174/0x340
>  [  354.422816]  worker_thread+0x27b/0x3a0
>  [  354.426586]  ? __pfx_worker_thread+0x10/0x10
>  [  354.430874]  kthread+0xe8/0x120
>  [  354.434030]  ? __pfx_kthread+0x10/0x10
>  [  354.437790]  ret_from_fork+0x34/0x50
>  [  354.441377]  ? __pfx_kthread+0x10/0x10
>  [  354.445139]  ret_from_fork_asm+0x1b/0x30
>  [  354.449079]  </TASK>
>  [  354.451285] ---[ end trace 0000000000000000 ]---
>  [  354.455917] BUG: kernel NULL pointer dereference, address: 0000000000000008
>  [  354.462883] #PF: supervisor read access in kernel mode
>  [  354.468029] #PF: error_code(0x0000) - not-present page
>  [  354.473167] PGD 0 P4D 0
>  [  354.475705] Oops: 0000 [#1] PREEMPT SMP NOPTI
>  [  354.480066] CPU: 1 PID: 11 Comm: kworker/u64:0 Tainted: G        W          6.7.0-991912.1.zuul.e7596ab24dae4bb686e58b0f1e7842da #1
>  [  354.491883] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>  [  354.499976] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>  [  354.506855] RIP: 0010:drm_sched_stop+0x61/0x1f0 [gpu_sched]
> 
>   The solution is every place where we check the ready flag and check
>  for ring->no_scheduler. The ready flag serves the purpose in case an initialization
>  is failed, like starting the worker thread, etc.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 14 ++++++++------
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 899e31e3a5e8..70bbf602df34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -292,6 +292,8 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
>  
>  		if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
>  			continue;
> +		if (ring->no_scheduler)
> +			continue;
>  

There was a similar patch before -

https://lore.kernel.org/all/7cd37500-8633-4030-aae3-9b532d60b501@amd.com/T/#t

It introduces amdgpu_ring_sched_ready() to cover the above checks.

Thanks,
Lijo

>  		/* stop secheduler and drain ring. */
>  		if (suspend) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index e485dd3357c6..35132aa2c0f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>  	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  			continue;
>  		drm_sched_wqueue_stop(&ring->sched);
>  	}
> @@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>  	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  			continue;
>  		drm_sched_wqueue_start(&ring->sched);
>  	}
> @@ -1916,7 +1916,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>  
>  	ring = adev->rings[val];
>  
> -	if (!ring || !ring->funcs->preempt_ib ||
> +	if (!ring || !ring->funcs->preempt_ib || ring->no_scheduler ||
>  	    !drm_sched_wqueue_ready(&ring->sched))
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2df14f0e79d8..894b657df1d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5052,7 +5052,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  			continue;
>  
>  		spin_lock(&ring->sched.job_list_lock);
> @@ -5191,8 +5191,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  			continue;
> +		 if (ring->no_scheduler)
> +			 continue;
>  
>  		/* Clear job fence from fence drv to avoid force_completion
>  		 * leave NULL and vm flush fence in fence drv
> @@ -5658,7 +5660,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  				continue;
>  
>  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> @@ -5727,7 +5729,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  				continue;
>  
>  			drm_sched_start(&ring->sched, true);
> @@ -6082,7 +6084,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = adev->rings[i];
>  
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  				continue;
>  
>  			drm_sched_stop(&ring->sched, NULL);
> @@ -6224,7 +6226,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>  			continue;
>  
>  		drm_sched_start(&ring->sched, true);
