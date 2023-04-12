Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49910C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 00:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADFF10E6CD;
	Wed, 12 Apr 2023 00:00:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEEE10E6CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 00:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZzVIlsZNCjqpix9mwaVoeplnZYUd7OGJPEprmImZN/wS+PS0A3IVt0ZuwutLjw/V7MARS4VOW2QY1zxjlKdUsVEVAoCAql5RWFPDvRXaNi+aNFQqFqjw9XPAEZ0N5LHcVJFwM+XTqbMGH5+U26cvNXkrrWoslMF5QXNVjYFMLNc9uUpaimNGm9hdPW76WUGgFVdQJU/2cJ7ETOKhH9rmoUbrGKiopCbmInzlsge9RPTwhS9CiQVPF9KdV7wuquoprOSbGVO6aZovkcy+poQt142k6vOp+ueEvfJTOhf81K0rzHrOj3N2ATkcl/Rd12Dx3WM/DqC5VddsUDXSZ+mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmTLTTpewdbJqV9yscq5yjsVNiZuVLp1v+QHH5GVEZ4=;
 b=G7dDSdaVFI82BO/pK9G49SAb4TJ95mQaPQhJ5mBRQO8kwUaLmMIPWCXg0ad3qcIqjyKIpruFs/MaDyqmZd8lvxQPzcg0aedIYQROq7nCLJMtkFCt9AgmnwCnfUFKT23x40nKtS24JEjYwDVDslu4iCh2w5iaxpBPGpgiN0o+UT2UW/FVLXHz+XKV6miZ9oyCnwZ3xJoG0cKeok7YuxSqTClxdVLcqQehlemotXgDqJKAF6RZOYD/W3zm8Te0pc+VWDQxre0FrQf8w3+ZBwbGBXPqJAalQYWsFjGvY5l1/gz/1G+eCzV60jUPu84IwtJD90kIFtPCbturox/SyPSX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmTLTTpewdbJqV9yscq5yjsVNiZuVLp1v+QHH5GVEZ4=;
 b=jfcSsEyzDo5W91WGWht20nDdbcF6cKegFgr/r8W9dofLFYXeWtvKdnZLY65rTpv37SMj6fXHeuzr/oiQ14caXYDZPGqaoB6WVOZkp2oCuw+jSpwxMlARFoHrJScGlFUOjtDbq65yUJGRHtpR7kHyyMqJGq6vqPaGoRRvmqkLo0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 00:00:43 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 00:00:43 +0000
Message-ID: <b959acc1-b504-8489-4e6b-1beb1d08e995@amd.com>
Date: Tue, 11 Apr 2023 20:00:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/sched: Check scheduler ready before calling timeout
 handling
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230406200054.633379-1-luben.tuikov@amd.com>
 <CADnq5_PdpyvkzQftKcRW7KCTn6tfhWP8u+DyN9F_BG8XfOmEeQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_PdpyvkzQftKcRW7KCTn6tfhWP8u+DyN9F_BG8XfOmEeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 53933530-2d01-4e20-fae6-08db3ae8f54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXmnmZv59KV/2CGIxVn7x6VDuogmq+pqQ97+wRASeCm1vJbOCs2NW6qa8tHVtcC1mBxSGF76Ua5ZobnZzBKUpAyrIJjSDBM4mL6aKGD7IsR2gig8mX+EOxyvHnCcyawdEaHSyVAcE9yqntjc8j591oNlAvWuzo+VH/Fz60MfbuWJrVNdZmpUOYVLklAboB8hF4zYReXoo68LcqWYD3FgiiA7OyoM8xRsHXc92sDG7OSip6nYosDlhcLFa2TzYPCgVQZ5KXu6SKujB+wQAa0/J419CXLz4CHi6TUbUw0SlXIAFzIP+/A9e0gileYEqnXo7S7+/yeNg483366iToceTmi7pEVxrb1gxfK4jXscRi/bxmOJXghhbeL2Y/BwJJ8zCzIJWwRe+N6coR2HcrVEAR3oKSetM5GKq+q/s2czGyoLWurhicjmbYqtxjBsoQmRwYDZ35vwOo8hHOmN2GCeaFeQIUZoUNO4ZFD0xPgzV5JjHyHoerD1tKJcY1jJlMoXilv5NUQKqaVsk4SO4BK44POH0Y1Dbam4AS48w0e5xFZG00IZjgkqg5dcY35QbdUYxWVU7rrcP7MluOYZ8mA377hzM3o0akc04R6mAGi98bEZIae8FzH+JxS31Vh4Gu64HiVLbxCzdIH9L32zBeSdzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(478600001)(45080400002)(53546011)(26005)(316002)(6506007)(186003)(44832011)(5660300002)(54906003)(2906002)(66946007)(4326008)(8676002)(6916009)(6486002)(66476007)(41300700001)(66556008)(8936002)(66574015)(31696002)(86362001)(83380400001)(6512007)(36756003)(2616005)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJ2ckovQTlubXVVTXVSbEJoWkJCTDFGSDhJdW1MMGJma0toRXVyR0ZVWDFU?=
 =?utf-8?B?YWZINEpVYjVkN3drM01QS2poN05LYnYrVGVnWkxpZ21zSzV2WWl2N2cyVUdi?=
 =?utf-8?B?dUFiTWNxSVBlTmJwd2RRWEtHNmtUTnZSUnVEV2IvMmxQMzFVNkwwWi9ZeHRO?=
 =?utf-8?B?UG9jU2FxUklTOG9OdkFyeGkvb2FSYmo2WFIvbklNZEFPeFpYcVJXV1h3Ymhp?=
 =?utf-8?B?OTRUZDNHMG5FUWVQMUl0Q2dBdlZFSDZlWG8xY2oyb0JXdUhoVkdIMFdPMG1B?=
 =?utf-8?B?Mng4M3NsU3hlYmdTRXh4Y1BqZ3ZyQTBhNk16ZFpvak9uSUZFSnJTVGpYeUlS?=
 =?utf-8?B?TnJHV3Noa0ZCdXp3L3N6VnJVMzVhckVDazJhNi9hZW9RMXBucGt5bmlCV3Zt?=
 =?utf-8?B?VGtBYzN4SFFkSHl6NXJwa0VVMURJdFNuUmRGZzRPSkd4c3J6TUxVVW1wNDlM?=
 =?utf-8?B?cXBwMFdrVnBiTGw4QUFvZWhYQlh1a3BIaVZSUzIxUlVGcjIrTy82S2tOT2tO?=
 =?utf-8?B?eDZIalU5angwSGpGSlFaZHNZY1BGVVNZRFMzY1VudFVuVE1iTVB4T004MDlt?=
 =?utf-8?B?ZDBnUmw1dVAzdEsxVWx0MGY2ODB6YktqZ1I4Wk9PdTFFcitIWENuRjFkdDJ6?=
 =?utf-8?B?S0pwNTA1WTRiZUdHS3J4ZnorN3FVaHlmOUtXeFJPNis2dmgxVzhoQkFLakdr?=
 =?utf-8?B?UTltNWJPSmlZcDVLNTc4NDRtOXQrNm5IZmRQMHdzcnJHdGMyTStoZjNYRFhI?=
 =?utf-8?B?em5vcWdZTG9UMnZLcExmcUY1RUJCMklxQWtEaDdCNENVZG4vM2ExN25rZk1C?=
 =?utf-8?B?NEU4U25nU3cyL0Q0Y3pRUFp1RkEyQ3dIWWRzdzJtaUM5bmdUL21ZZEY3Tk13?=
 =?utf-8?B?cU9KUDh5R1BtMStkLzVJa2RQR0xmdU0xVkdvTjFXMG9MYlJFZ2F5UlF5bGUy?=
 =?utf-8?B?ZE9ocjltN3RyQzJEOHBVcEdKNUFpTHhYeHJWU1RzaUowQjRvQ3FxeGF6RUFo?=
 =?utf-8?B?QXFzNUQ0QTNUWkc0bHFVcmdDcHJuekg5VFNxdTlIRHVDSkdQQTBXRGQ5cDRp?=
 =?utf-8?B?U2c4dnN2TDk4Sk4rYlorTlRrb0lDSWhMSnF4Ti80Rm1VTHBIdmFpUHVQeEND?=
 =?utf-8?B?dUJPajg0SzhJOHUra01rLzFPTC9YbVhldWpkTDRkZSswQlpaamtsNXlqa3RY?=
 =?utf-8?B?bjFzQjVzbktuZUhxbnZVcEdKbWsra21kUTJ3WHdMMVlpenZ2b1g4UUNrb21o?=
 =?utf-8?B?dldLL3d4MEs1bUwxVWV4UUEySHJJKzRQcnpqdDBKN2JubzhtK0hFZXRUSDVs?=
 =?utf-8?B?QlRXRDVXRHFVZEhaVFpOTEl3NUZlZU5Zcyt5ZVRCNEc2ejY2ZndCdjZ5cnY3?=
 =?utf-8?B?Mmp1alQ2YzU2ZGFGa0F2WFJ3R0VETHd3VkppWDBERWRqNEZJUzZuS1pVZGVS?=
 =?utf-8?B?a3NyWStUTERhMjZxMmpJZ0JKZnhxbVZJTndTK0N6NDRNTjRQRkVNMFRxRW5j?=
 =?utf-8?B?bnJDNGliV2dqdDFIakFuWVo5OFQ2RnllSWtvZmQrZVJxL2ZDcFlBWWFYcXJP?=
 =?utf-8?B?ZENhcmI4L2dWYmRNajRpY3ZQT1Y4OUJDTGc3UXdRNDJmWFMvd1NFVWsyUUll?=
 =?utf-8?B?S1UxbmZzbmwwUnBEVStXRVdQQ24xaXBhOWxzaUNwUGFlaTZuSmk1bTNkQlZh?=
 =?utf-8?B?aXIvREFVaEFwenFlMUdYbnNXUUZzb2JQc2piY2paZGZ1aGhrMWgveVlLQ09O?=
 =?utf-8?B?aC9VUjVxQk5tQ0QzeHVvd0ZuYU1odVNEaC84ZkR1WGtwRDJjZlZqTU9Cc3JN?=
 =?utf-8?B?Y0lsV1FKYnN5ekNCVlpoSU5uRGtiNWd1WjZKVlZuQzlkSEpBS3ZYMCtDQnkr?=
 =?utf-8?B?RlhJTC80clJVbTRKVGh6cndnV0N6aGYvS1UzQkVrZnovWG15ZStXcFA2K0dQ?=
 =?utf-8?B?ZE83SzNuNTU4YUZZRStFMGlwTy9JeVJDaFdIdXIvNEpqR0R3V1dFTzVtZThp?=
 =?utf-8?B?V3E0MDU5T1d1YXJja2RRNVZzTThrc05PVFRxelFYN2ZwcDUwdWR3VU5uOHZm?=
 =?utf-8?B?b1Y3K25xOXlQUllyS2MrbGhqK0dMYTRwb0RwdkVKdFgxMHNXWHVSNFVaRU9Z?=
 =?utf-8?Q?KOQryzOhXJkXFLztqz0wrLjUm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53933530-2d01-4e20-fae6-08db3ae8f54a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 00:00:43.2201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk9aXxrwu372bvi7m/szBGKeV1XFWPxmUdS42/I5ji4RvNWWhCfmgb+XfHeWt/ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-11 17:39, Alex Deucher wrote:
> On Thu, Apr 6, 2023 at 4:01 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>> During an IGT GPU reset test we see the following oops,
>>
>> [  +0.000003] ------------[ cut here ]------------
>> [  +0.000000] WARNING: CPU: 9 PID: 0 at kernel/workqueue.c:1656 __queue_delayed_work+0x6d/0xa0
>> [  +0.000004] Modules linked in: iptable_filter bpfilter amdgpu(OE) nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core iommu_v2 gpu_sched(OE) kvm_amd drm_buddy snd_hwdep kvm video drm_ttm_helper snd_pcm ttm snd_seq_midi drm_display_helper snd_seq_midi_event snd_rawmidi cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_seq aesni_intel rc_core crypto_simd cryptd binfmt_misc drm_kms_helper rapl snd_seq_device input_leds joydev snd_timer i2c_algo_bit syscopyarea snd ccp sysfillrect sysimgblt wmi_bmof k10temp soundcore mac_hid sch_fq_codel msr parport_pc ppdev drm lp parport ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid r8169 ahci xhci_pci gpio_amdpt realtek i2c_piix4 wmi crc32_pclmul xhci_pci_renesas libahci gpio_generic
>> [  +0.000070] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
>> [  +0.000003] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
>> [  +0.000001] RIP: 0010:__queue_delayed_work+0x6d/0xa0
>> [  +0.000003] Code: 7a 50 48 01 c1 48 89 4a 30 81 ff 00 20 00 00 75 38 4c 89 cf e8 64 3e 0a 00 5d e9 1e c5 11 01 e8 99 f7 ff ff 5d e9 13 c5 11 01 <0f> 0b eb c1 0f 0b 48 81 7a 38 70 5c 0e 81 74 9f 0f 0b 48 8b 42 28
>> [  +0.000002] RSP: 0018:ffffc90000398d60 EFLAGS: 00010007
>> [  +0.000002] RAX: ffff88810d589c60 RBX: 0000000000000000 RCX: 0000000000000000
>> [  +0.000002] RDX: ffff88810d589c58 RSI: 0000000000000000 RDI: 0000000000002000
>> [  +0.000001] RBP: ffffc90000398d60 R08: 0000000000000000 R09: ffff88810d589c78
>> [  +0.000002] R10: 72705f305f39765f R11: 7866673a6d72645b R12: ffff88810d589c58
>> [  +0.000001] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000000000
>> [  +0.000002] FS:  0000000000000000(0000) GS:ffff8887fee40000(0000) knlGS:0000000000000000
>> [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  +0.000002] CR2: 00005562c4797fa0 CR3: 0000000110da0000 CR4: 00000000003506e0
>> [  +0.000002] Call Trace:
>> [  +0.000001]  <IRQ>
>> [  +0.000001]  mod_delayed_work_on+0x5e/0xa0
>> [  +0.000004]  drm_sched_fault+0x23/0x30 [gpu_sched]
>> [  +0.000007]  gfx_v9_0_fault.isra.0+0xa6/0xd0 [amdgpu]
>> [  +0.000258]  gfx_v9_0_priv_reg_irq+0x29/0x40 [amdgpu]
>> [  +0.000254]  amdgpu_irq_dispatch+0x1ac/0x2b0 [amdgpu]
>> [  +0.000243]  amdgpu_ih_process+0x89/0x130 [amdgpu]
>> [  +0.000245]  amdgpu_irq_handler+0x24/0x60 [amdgpu]
>> [  +0.000165]  __handle_irq_event_percpu+0x4f/0x1a0
>> [  +0.000003]  handle_irq_event_percpu+0x15/0x50
>> [  +0.000001]  handle_irq_event+0x39/0x60
>> [  +0.000002]  handle_edge_irq+0xa8/0x250
>> [  +0.000003]  __common_interrupt+0x7b/0x150
>> [  +0.000002]  common_interrupt+0xc1/0xe0
>> [  +0.000003]  </IRQ>
>> [  +0.000000]  <TASK>
>> [  +0.000001]  asm_common_interrupt+0x27/0x40
>> [  +0.000002] RIP: 0010:native_safe_halt+0xb/0x10
>> [  +0.000003] Code: 46 ff ff ff cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 69 f2 5e 00 f4 e9 f1 3b 3e 00 90 eb 07 0f 00 2d 59 f2 5e 00 fb f4 <e9> e0 3b 3e 00 0f 1f 44 00 00 55 48 89 e5 53 e8 b1 d4 fe ff 66 90
>> [  +0.000002] RSP: 0018:ffffc9000018fdc8 EFLAGS: 00000246
>> [  +0.000002] RAX: 0000000000004000 RBX: 000000000002e5a8 RCX: 000000000000001f
>> [  +0.000001] RDX: 0000000000000001 RSI: ffff888101298800 RDI: ffff888101298864
>> [  +0.000001] RBP: ffffc9000018fdd0 R08: 000000527f64bd8b R09: 000000000001dc90
>> [  +0.000001] R10: 000000000001dc90 R11: 0000000000000003 R12: 0000000000000001
>> [  +0.000001] R13: ffff888101298864 R14: ffffffff832d9e20 R15: ffff888193aa8c00
>> [  +0.000003]  ? acpi_idle_do_entry+0x5e/0x70
>> [  +0.000002]  acpi_idle_enter+0xd1/0x160
>> [  +0.000003]  cpuidle_enter_state+0x9a/0x6e0
>> [  +0.000003]  cpuidle_enter+0x2e/0x50
>> [  +0.000003]  call_cpuidle+0x23/0x50
>> [  +0.000002]  do_idle+0x1de/0x260
>> [  +0.000002]  cpu_startup_entry+0x20/0x30
>> [  +0.000002]  start_secondary+0x120/0x150
>> [  +0.000003]  secondary_startup_64_no_verify+0xe5/0xeb
>> [  +0.000004]  </TASK>
>> [  +0.000000] ---[ end trace 0000000000000000 ]---
>> [  +0.000003] BUG: kernel NULL pointer dereference, address: 0000000000000102
>> [  +0.006233] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout, signaled seq=3, emitted seq=4
>> [  +0.000734] #PF: supervisor read access in kernel mode
>> [  +0.009670] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process amd_deadlock pid 2002 thread amd_deadlock pid 2002
>> [  +0.005135] #PF: error_code(0x0000) - not-present page
>> [  +0.000002] PGD 0 P4D 0
>> [  +0.000002] Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [  +0.000002] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
>> [  +0.000002] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
>> [  +0.012101] amdgpu 0000:0c:00.0: amdgpu: GPU reset begin!
>> [  +0.005136] RIP: 0010:__queue_work+0x1f/0x4e0
>> [  +0.000004] Code: 87 cd 11 01 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 d5 41 54 49 89 f4 53 48 83 ec 10 89 7d d4 <f6> 86 02 01 00 00 01 0f 85 6c 03 00 00 e8 7f 36 08 00 8b 45 d4 48
>>
>> For gfx_rings the schedulers may not be initialized by
>> amdgpu_device_init_schedulers() due to ring->no_scheduler flag being set to
>> true and thus the timeout_wq is NULL. As a result, since all ASICs call
>> drm_sched_fault() unconditionally even for schedulers which have not been
>> initialized, it is simpler to use the ready condition which indicates whether
>> the given scheduler worker thread runs and whether the timeout_wq of the reset
>> domain has been initialized.
>>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> 
> Please make sure this lands in drm-misc.  Generally all scheduler
> patches should go through drm-misc unless there is a particular driver
> dependency.

drm-misc-next, drm-misc-fixes or both?
-- 
Regards,
Luben

