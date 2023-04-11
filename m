Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84165C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E881010E50E;
	Tue, 11 Apr 2023 08:35:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D7910E4E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhFKoUQdqaUbgPhyPhW+rvo4xyKHSYPCTukMU+G6VwGFvkxb46fxCjUHCAXlF6jYeBcdjELUlKlGAUBp+c5F5vuzcZd1ZY2a/8POhwclbTsCl9scIdU3npkPJcL/8XzeVRpJjYhQFB+LjCuW41dTlKbMg9YCA3e1xU2l0GwIivRM4X7oAPrV3IgigY3tk9SqVJQwLn75vDZ7NSQWpmFKYrABdRn1Z7DfLO82OqdFGdGKSUjV5XUWM8huEDaBmWDd9S8N6r/03qVAjGMoQ/OZ5Svkhv80vcd8RtW4MxCIPNJ/XZ1swAQSRTVWDPcGzT7gOuav/HnMTLvHFBD9OsdVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvRLAp+hDj/yzQQOaMko45vUUkxDbGpAAf30NsB9qr4=;
 b=m8PgrFhFwONwSD5Q9h4DCpOp2cq4rwYeparP/xknNGnrs9uuemhx7vfaXOceP9C7vEsm6lhn81su7uPQvCPJ/2ZpNaXl+65+6dDlE+Msw5eLsD1yWfWmu3+JPTDL10LdQydqcC72KKLbBtMcuUCyX/RDxg10c69IkumpMba/O6jl8dEh1enKxxKZ8Y1dDyijdMO0YEUn7jN/aiUfMbJq+aizBrQOiOafZOOGMEmZ9P29Ub0d6JfRtUL6Nn6zTqv+/sbRzFha3adVvwfi/RmFf2nJW/K1xiotYRktdO3XNYTylSgNjfTNwwpQNL7qO3rYKeDNxkqfTdmPkKJA6NGIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvRLAp+hDj/yzQQOaMko45vUUkxDbGpAAf30NsB9qr4=;
 b=nAlPpEhV7Pkeu3emgO7lLFdBdaoutoyXq8J6IVR2Jg41ipyAeWX/I8c3C2UCMRq/i+30RViqdzbtwzCpho/oJTpEz92YEBmrbltvbhZEdqPv1E1XWOY8HIglDX2kjJWtEj7vB/GC6Ms0FkBKMA0kroX2NpC/ri/nV0fhdyci3xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 08:35:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 08:35:05 +0000
Message-ID: <f6b10d22-3f54-0c87-60ac-f5dfc669683d@amd.com>
Date: Tue, 11 Apr 2023 10:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/sched: Check scheduler ready before calling timeout
 handling
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20230406200054.633379-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230406200054.633379-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c86e81f-3935-4a04-d833-08db3a67a666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0P0TgV4e67jdLxt4l9SCCjk2Wm0iwSqgLUs0TlKifErWsFXXgwdubOj92//7Ohevy2/5w1EE25W1hESJ/5oX1E+L4LX6SipWo5+fo2lxxtekwj2sf6wBhY6vu0zWHd0kAb6REJ7pFh1w10k4UUbrL6eBxtaDvEBdHpc74CDYkX+5MMh5VYMecfhzA/qcGtd0hCFs94vI9Ln3SjrbEgMchHQqSXvfoPjAqrhFT6e7E2zfrvMONSqpUe7dbi0WM9F0t+gD07rmYRhQv/avUqvPtBRT3O/whOMEgqcpU4ZJaJ5nuE4wxMoGWcqhxVKaq0VNN9mzNosv3GKllsZjIucCifAQYaCVRcjkRI3LSwCrPk0LrqaPTwXqLc22BX54bVrwrWSOf1rEB40xyZCH3PCc1eFsP7lS6EuWS0q0bQNQx/f/KHFqXZ0GxXAw2sIvCWG4LdWngp/qV8YCn2ifazA9GhkBZuP6XGD9adxzPnFT9vsaLr/kCdKDkfCs9RGjxSKJx8K+XfVnh5jwQWh25lWz6TOLuwt/Y+EdqhKXUMZaoqzlhTLBLdTDgcM5Nibhm1J+tTyBptOKNuyYYgKYMQ1xM5ZuWPZGbGqaaFUpFCMfyCMB1BN/W8PGAnXULpPsuFT4ZpcoUAE5whKGpZo+maLuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(36756003)(31696002)(86362001)(41300700001)(110136005)(316002)(4326008)(54906003)(66946007)(8676002)(6486002)(66476007)(478600001)(66556008)(5660300002)(8936002)(2906002)(66574015)(186003)(38100700002)(6666004)(6512007)(6506007)(26005)(2616005)(83380400001)(45080400002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJnbStMdm9yYTZOUUNENUNrcHFldFo4dlowSWJISGJNdE1MZXNVOC9tUHR4?=
 =?utf-8?B?SmZsYjcwd2w0bDFFV0l1YXJxOGJydHJSZTJqdEwyY3RVcnJlVTZpaGt6WjZp?=
 =?utf-8?B?Ym5IU3pFeWplV1k0U0FJd01HMTl0emZPZmt0TWFTZWFTVDF2L2l3QnNGS1hv?=
 =?utf-8?B?S2hPR0NaUDdSdERQT3MybFV2VWtHVDFDY1hJbStselZVZHNicUJtVzU4VHFB?=
 =?utf-8?B?SzFGUCtMM0RVT283NUZZV3BmbmRqbThncjN5VmtreS85eWM0YWxadDhJc0ds?=
 =?utf-8?B?SkJNNSs5bUY1bHlvMXYzRkJBbzJwdkIvd0JyNmlMTld1YW9QNDU3K0VYc0hr?=
 =?utf-8?B?L1VIOFgvbVB3d25Mcms1b1lPUXZhbEt1UXBLcXFFRExVNEFQdmVPK094di9Y?=
 =?utf-8?B?OXJydGo3L0cxZnR4V3Jza2kyUVd3NzNDQ1c3RGtncWNtRFNUTUxGcXo5bktH?=
 =?utf-8?B?cSsvaFc5K1BId2ZXRURWdHB5VEY3TXBOOTZ3ZnVFL2hSbjNzR01RemloYUI2?=
 =?utf-8?B?SnhpL1JCVGVwNUtlZzlXRHh6VlUyYmgvTEhxZGVuRnRNNHE3Nnh1akNBZEMv?=
 =?utf-8?B?RXlpYkZkWTdMTWgxY0U2YUZGRDhPcE1xekVHQVB1b29rWlRneE52R0dHNldi?=
 =?utf-8?B?c2t1NmNhdUxLNnpmWUUyL1RGUXR5UWpZUjI1cWdUdFY1aWwrUTdlYVJGdjk5?=
 =?utf-8?B?SXFEWERMNzl5OVc4V1BTVDlBSW5Ba1Z1OWNCblcyUko4emd6bU0wVC9FanBJ?=
 =?utf-8?B?YXNHT28vZXp6N1JYZjJVOUNqMU9GSzVvSTN0dEpUQWY3YTF0VW9ZSmpTK2NN?=
 =?utf-8?B?OWtaekhDQU8yc09iZVpXcDBSWkx4V1c0Q0Q1N3c1bVhjMGZNSDkwTE9BYU1n?=
 =?utf-8?B?ZUQvNWhJZ0FpWGdIQzFGbnZQbk9VeUhMLzBCamc5Z0hyOERGM3dNajdTV1Zx?=
 =?utf-8?B?UEtDcm9aaW8xc3U0ZHhnbTJwZFQwOUhaTStYakVoZEFPa0M3djBrR2IzYzM1?=
 =?utf-8?B?eGZHWkJqYVpGVC9wdUhVVkw5L1MwdzVGWUx6OXFuUWE2cnB3bldxcUFhb3hm?=
 =?utf-8?B?N2hUSjg4RE9HV3pMdEIzMXBzOFlwMG1VZzVxWVVMQWFsNTJrVWx2SE1LclFs?=
 =?utf-8?B?cnNlOGlSaS9TRmc0WHJ0UkpuWDNoL05IRU01KzFmT0drL0hlODdDSTlnS1Uz?=
 =?utf-8?B?UFdodCt1RW5TbDNJQ0FOVHgxTW5LMXh2WUVFQzJkdE9ZVGxldnVKNHVnbjdW?=
 =?utf-8?B?UlBKN0lJbWo0Z3R1TDMrUjhMeDZyL0IvKzM2ejM5dVBUVkZKZ3FpTFUrbzJR?=
 =?utf-8?B?cC9NZm1ORTczNzBCWTZMaXJkYVRTM3JqV1lHUHpPYVJpTVdSVDR5UXI1Wld6?=
 =?utf-8?B?bmcva0o5T0dTUVVJK2Zqay9XQlE1VEt5YnRYUndzV21sQ0NST0NoZWtXYXhE?=
 =?utf-8?B?ZktFcTFxYXVGZkFBNVNFbG9JZlVmTmRFZ2ppd2pib3dMMVJONGZvV3k5WU5x?=
 =?utf-8?B?YzFpMlJNTWJuTGdHcHZPQ2FSanFHdnhZSmxIdWhLcGUxQmF2RWZzblpiOEIy?=
 =?utf-8?B?N21OK1lES0RxaEo3cjFBWWJha0ZIcmw1Zk9Vcm5zYWo5Wk5hRnNEMjhNVHV2?=
 =?utf-8?B?NU5raEdtRDFqeWY0THpVbm9EalpzV1JKVFVRbFhrL2xBY0RId1J2N1ArVVJK?=
 =?utf-8?B?ekVST3RWQW1OZ1pocU5WbGcrU05zcDZIeGVjVDYwc0YxNGl1WDZza0VNcnYz?=
 =?utf-8?B?d2NuSys0OUxIKzJqWGh0aXBBVzR0MmhWdDZ0UnJjR1VyVW9Sci8rWUFTUjhS?=
 =?utf-8?B?cnpTa1JFZzk1RVRyRThxT20yd0ZodUZ3RjRBL3VncWlacWVNbGRYZWNyM0Zu?=
 =?utf-8?B?R1hRbTI4bHFrQXY0eHhhbm1XY1ZhZ3VHOElMYzYzV1FQVStocDNTNWt4a2Rj?=
 =?utf-8?B?UHRoTnBZcXVjZ2kzWHNhenZGQVZPb3FkZmNYNmdnVDJ5cFlpdCtFSkJza1kw?=
 =?utf-8?B?eHRTNXlCa0ExcmtzRnFRN2ZOSlM3Y3VMcEYxUm5wZER0R3Y4UjkxTUpmRDlP?=
 =?utf-8?B?SVo3M0tBQlpYZVB4QW9UeVo1NndoZjRULzlYYjhGZDBqT3BmMUxNZFZQTzlC?=
 =?utf-8?Q?WnW+kmA5sB+vqzxdKhsE1g/n3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c86e81f-3935-4a04-d833-08db3a67a666
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 08:35:05.2989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8mUCZE3VpWYzmT8mRYN4IKS2yE3So7x/vSlISPmigrO/uIwgW3t8GSmlz4oQcoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 06.04.23 um 22:00 schrieb Luben Tuikov:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> During an IGT GPU reset test we see the following oops,
>
> [  +0.000003] ------------[ cut here ]------------
> [  +0.000000] WARNING: CPU: 9 PID: 0 at kernel/workqueue.c:1656 __queue_delayed_work+0x6d/0xa0
> [  +0.000004] Modules linked in: iptable_filter bpfilter amdgpu(OE) nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core iommu_v2 gpu_sched(OE) kvm_amd drm_buddy snd_hwdep kvm video drm_ttm_helper snd_pcm ttm snd_seq_midi drm_display_helper snd_seq_midi_event snd_rawmidi cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_seq aesni_intel rc_core crypto_simd cryptd binfmt_misc drm_kms_helper rapl snd_seq_device input_leds joydev snd_timer i2c_algo_bit syscopyarea snd ccp sysfillrect sysimgblt wmi_bmof k10temp soundcore mac_hid sch_fq_codel msr parport_pc ppdev drm lp parport ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid r8169 ahci xhci_pci gpio_amdpt realtek i2c_piix4 wmi crc32_pclmul xhci_pci_renesas libahci gpio_generic
> [  +0.000070] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
> [  +0.000003] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
> [  +0.000001] RIP: 0010:__queue_delayed_work+0x6d/0xa0
> [  +0.000003] Code: 7a 50 48 01 c1 48 89 4a 30 81 ff 00 20 00 00 75 38 4c 89 cf e8 64 3e 0a 00 5d e9 1e c5 11 01 e8 99 f7 ff ff 5d e9 13 c5 11 01 <0f> 0b eb c1 0f 0b 48 81 7a 38 70 5c 0e 81 74 9f 0f 0b 48 8b 42 28
> [  +0.000002] RSP: 0018:ffffc90000398d60 EFLAGS: 00010007
> [  +0.000002] RAX: ffff88810d589c60 RBX: 0000000000000000 RCX: 0000000000000000
> [  +0.000002] RDX: ffff88810d589c58 RSI: 0000000000000000 RDI: 0000000000002000
> [  +0.000001] RBP: ffffc90000398d60 R08: 0000000000000000 R09: ffff88810d589c78
> [  +0.000002] R10: 72705f305f39765f R11: 7866673a6d72645b R12: ffff88810d589c58
> [  +0.000001] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000000000
> [  +0.000002] FS:  0000000000000000(0000) GS:ffff8887fee40000(0000) knlGS:0000000000000000
> [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00005562c4797fa0 CR3: 0000000110da0000 CR4: 00000000003506e0
> [  +0.000002] Call Trace:
> [  +0.000001]  <IRQ>
> [  +0.000001]  mod_delayed_work_on+0x5e/0xa0
> [  +0.000004]  drm_sched_fault+0x23/0x30 [gpu_sched]
> [  +0.000007]  gfx_v9_0_fault.isra.0+0xa6/0xd0 [amdgpu]
> [  +0.000258]  gfx_v9_0_priv_reg_irq+0x29/0x40 [amdgpu]
> [  +0.000254]  amdgpu_irq_dispatch+0x1ac/0x2b0 [amdgpu]
> [  +0.000243]  amdgpu_ih_process+0x89/0x130 [amdgpu]
> [  +0.000245]  amdgpu_irq_handler+0x24/0x60 [amdgpu]
> [  +0.000165]  __handle_irq_event_percpu+0x4f/0x1a0
> [  +0.000003]  handle_irq_event_percpu+0x15/0x50
> [  +0.000001]  handle_irq_event+0x39/0x60
> [  +0.000002]  handle_edge_irq+0xa8/0x250
> [  +0.000003]  __common_interrupt+0x7b/0x150
> [  +0.000002]  common_interrupt+0xc1/0xe0
> [  +0.000003]  </IRQ>
> [  +0.000000]  <TASK>
> [  +0.000001]  asm_common_interrupt+0x27/0x40
> [  +0.000002] RIP: 0010:native_safe_halt+0xb/0x10
> [  +0.000003] Code: 46 ff ff ff cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 69 f2 5e 00 f4 e9 f1 3b 3e 00 90 eb 07 0f 00 2d 59 f2 5e 00 fb f4 <e9> e0 3b 3e 00 0f 1f 44 00 00 55 48 89 e5 53 e8 b1 d4 fe ff 66 90
> [  +0.000002] RSP: 0018:ffffc9000018fdc8 EFLAGS: 00000246
> [  +0.000002] RAX: 0000000000004000 RBX: 000000000002e5a8 RCX: 000000000000001f
> [  +0.000001] RDX: 0000000000000001 RSI: ffff888101298800 RDI: ffff888101298864
> [  +0.000001] RBP: ffffc9000018fdd0 R08: 000000527f64bd8b R09: 000000000001dc90
> [  +0.000001] R10: 000000000001dc90 R11: 0000000000000003 R12: 0000000000000001
> [  +0.000001] R13: ffff888101298864 R14: ffffffff832d9e20 R15: ffff888193aa8c00
> [  +0.000003]  ? acpi_idle_do_entry+0x5e/0x70
> [  +0.000002]  acpi_idle_enter+0xd1/0x160
> [  +0.000003]  cpuidle_enter_state+0x9a/0x6e0
> [  +0.000003]  cpuidle_enter+0x2e/0x50
> [  +0.000003]  call_cpuidle+0x23/0x50
> [  +0.000002]  do_idle+0x1de/0x260
> [  +0.000002]  cpu_startup_entry+0x20/0x30
> [  +0.000002]  start_secondary+0x120/0x150
> [  +0.000003]  secondary_startup_64_no_verify+0xe5/0xeb
> [  +0.000004]  </TASK>
> [  +0.000000] ---[ end trace 0000000000000000 ]---
> [  +0.000003] BUG: kernel NULL pointer dereference, address: 0000000000000102
> [  +0.006233] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout, signaled seq=3, emitted seq=4
> [  +0.000734] #PF: supervisor read access in kernel mode
> [  +0.009670] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process amd_deadlock pid 2002 thread amd_deadlock pid 2002
> [  +0.005135] #PF: error_code(0x0000) - not-present page
> [  +0.000002] PGD 0 P4D 0
> [  +0.000002] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  +0.000002] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
> [  +0.000002] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
> [  +0.012101] amdgpu 0000:0c:00.0: amdgpu: GPU reset begin!
> [  +0.005136] RIP: 0010:__queue_work+0x1f/0x4e0
> [  +0.000004] Code: 87 cd 11 01 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 d5 41 54 49 89 f4 53 48 83 ec 10 89 7d d4 <f6> 86 02 01 00 00 01 0f 85 6c 03 00 00 e8 7f 36 08 00 8b 45 d4 48
>
> For gfx_rings the schedulers may not be initialized by
> amdgpu_device_init_schedulers() due to ring->no_scheduler flag being set to
> true and thus the timeout_wq is NULL. As a result, since all ASICs call
> drm_sched_fault() unconditionally even for schedulers which have not been
> initialized, it is simpler to use the ready condition which indicates whether
> the given scheduler worker thread runs and whether the timeout_wq of the reset
> domain has been initialized.
>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

It would be better to prevent calling this function in the first place 
when the scheduler isn't initialized, but it's probably still a good 
idea to not crash.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index fd22d753b4ed0c..fcd4bfef741580 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -308,7 +308,8 @@ static void drm_sched_start_timeout(struct drm_gpu_scheduler *sched)
>    */
>   void drm_sched_fault(struct drm_gpu_scheduler *sched)
>   {
> -	mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
> +	if (sched->ready)
> +		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
>   }
>   EXPORT_SYMBOL(drm_sched_fault);
>   
>
> base-commit: 49144cd279d047c1d572a57323df3af8e1461894

