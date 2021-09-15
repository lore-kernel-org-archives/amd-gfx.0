Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A077C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 13:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A0461250
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 13:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6A0461250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3BD6E937;
	Wed, 15 Sep 2021 13:52:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DB36E937
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 13:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKx/YTXtghWffgH147Towk47Y8epwa2Vl4yZ0KOjbrhwbotThIVHqVHIi0eWKQ/Vfb4xM5L73qUv7kib8gfvJZqelBDrh870XN4hxzwJLLoUM6boJzYnfwaeYNRTKaY/ZpOSCJV/ebRoBw7qBrLzhhARLde1M8fCYV2xf7ShWhhKbL/T4+R/34avNV6rwko//WFQPPkkCnGnkuYtbAHWhxSdA3Zr4za4JoTneBSY0xPjNKDxc4r5gf4vvbDMUqnOCQffBIelp3VyZcSHHuGzDzw+S60tZgIxvk+p5M0o5x+hHfO8FVHccwtrTqdM4BqfMUiDyJYsUhGgNAJSr/cAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ljJHgZLvyHV4RBI+n5JviVRDRcVJpmHpFyIMpCyQQhs=;
 b=U53MOfFfE2Y9ZxIJUS7+bbcX1VlNNtBA5exvbW/JlO4yQmjl5XNqjiJAfRlbMI4PxjHJa2690azE2r/5+jPyG2zXuvJYZ1QCUBbzTejSJOb/iHmybjk2y7nMLpyt6dNLEOh7aUXb5HSf4o5pUABNQ9z31yfaONrYPQVT3AU35KyGL9AgT02ApzHvn4bNtrmbcAwCoXsuYFxoBcXfIm2PTprd9wPd3B43vg6Vhd/FeVS/dZqqP9uw0iN/lHKE1T2aZ/REMC9aLGaz7nvlLOYRNLDQqhknkIANmzGR+lR/oe0ufJ9ZDdxZSi5GXqPIOHBTlPV/xX0QoSznzhmBvZZyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljJHgZLvyHV4RBI+n5JviVRDRcVJpmHpFyIMpCyQQhs=;
 b=YNlwkDPvd1CFkgQKvUaJ+jMWYl/asMbpQWXWtODoq+/dKSHlnPBIw7NixSBxIjv7cYPU5IosFUtjFYyxAikVTxa1cUT2RZwB+AmpPgtmgFnQDj9HUPeem5yTXhh9EVekspcIJElTE3vXsTal9xRQmTiFrOg7DC8rAjJujd8Bz4M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Wed, 15 Sep
 2021 13:52:42 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 13:52:42 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBQdXQgZHJt?=
 =?UTF-8?Q?=5fdev=5fenter/exit_outside_hot_codepath?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20210915063739.31244-1-xinhui.pan@amd.com>
 <DM4PR12MB51651F702F35D31B4B76F90287DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <5a18c2bb-c919-817f-2dc1-a6bb0bfd9701@amd.com>
Date: Wed, 15 Sep 2021 09:52:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB51651F702F35D31B4B76F90287DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b478:f3df:a528:4eef]
 (2607:fea8:3edf:49b0:b478:f3df:a528:4eef) by
 YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 13:52:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768e1697-aaa7-4516-5f70-08d97850168f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27047EE7191FE87FFE2CD5F3EADB9@SN6PR12MB2704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6WITIsMoLQoCWSo3SpT24w1pU42NNUViFEI6t3Badkn9Jz3Bsa5Lbp7QY17TLJAjQ1N6CFViFXA+1tg6WrDH5eR7+3G/r8lMaUHeJP9sCSZC8YQMVRg8VKCQi8aq7JZ/8lUbURoUKr9fo1aa8AO8coTBn/TQcN86BvVh06NRhAftbNecDxFMXykMcm5XB1ZuNq+JGjImlKQ/HO3u7wUHrkL0AVIo1GQAh5nahzfXM4xiPXtXp9OfhPgw77skwDJrPv0ix2NCtonLYXz8R0pZOJLnqGP6bWr6ot4H3H02w7tOzKZeYcfoXgbu9lB3cyRP7ccs8+5J0HsKQ7/zdEYFhjshybsk1SieHiljCp2olD6tKNBEO1w01crXZe9Qpp1uHeOeyOYDbaZZnl2VNqqIihIxzZZhymUUfs9AF/2P8H2cUDqq0yhoI49vARhBxkOYXOUxmLTsSI6ezTZIjxWdtQejn0W1b6ZkeKGGi73F1Htn9syTitV20NQ/E2mmu34VwqWR7rZ02eQBEukGxJFiF3jJA2hBhSHdOwp0XGnFCpwjpg+pHNzM8M1zX/GMvpbuDuBj/rjIfqpQ7WMs1EgcQshVB19DKS5dlmqjIxypw71Vh1WjWgU9Ksya0FYfaeYJZ/VwnB0Y9OcvvoBnkxYAvNpjGfZwqHtMvq1G7x67+dX1mqtgZqLgfzw9jiPu5DbLCiJO1xJ0A48we+ONoxe7Kh6SD+uM0c/fS3evILhz6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(44832011)(31696002)(2616005)(36756003)(66476007)(66556008)(53546011)(478600001)(86362001)(2906002)(186003)(83380400001)(38100700002)(31686004)(110136005)(5660300002)(4326008)(8936002)(224303003)(316002)(54906003)(66946007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRGVmVIcXpkeFZDbXNvdC9zYTJ0blRtbWJQMUJBZWhDZVYzemoyUzZuTncx?=
 =?utf-8?B?S2hmVGNkTHpXdHprZDFzZU5XMmtCc0FEZ2xHenJBeWc5STdraE5TeUZLQmRN?=
 =?utf-8?B?RUhacnpialdET2FUY2dPRGtOSk1UOUdmbzYyYWNaNHBITWVVTlorNlp3Z05G?=
 =?utf-8?B?QStCM3ZvaW9BbHdEcFdhUGpyRFpTNkhGeW1PQVdGSmhKMzZiZVRqVVBseUtq?=
 =?utf-8?B?REEweFcyR3ZESDllR2NFSTBqalhIQmJGWW5TSlcyUEF4RWxYMkhyK1NIK1E1?=
 =?utf-8?B?amJwSnRSWkEyVTdOZEFyUzFjMlBFRDNkbkowdXAzcnJHOHZ2US9BY29wWUFK?=
 =?utf-8?B?SFdlMStQd1MxQjNRYWFUaVorbCtQa3dpeGdXRVhzWThTMGpoc0lBc2VvM1VN?=
 =?utf-8?B?ajQzbnQrdjJ0SjVTdnprQVl1ekU5MVFadklWSmhiMUE5enFmYTdmRkFqQkE4?=
 =?utf-8?B?UGJZY2dPUHhsMW02d0w4dGk1WXE0Y1NpaUZ6K0xrZ1JVK3hzYVhNUGlSWUp0?=
 =?utf-8?B?aWQ3S01mdTFhMlhxSkszQWk5MGd6SGFQaDhFZkIvaTFpMmp0NVhzRzRBWlJo?=
 =?utf-8?B?UzFEdk9QVVdUUHJFME9SdmVZQUttTFE2WGNORnBmNWVKVG0zOUdsV0t2Rkli?=
 =?utf-8?B?MlJ4a0toK2R2dStqdU9HbVBtaEdKRjRrVUZ4aThQWlpkK0NQdGdBaWF0TmhO?=
 =?utf-8?B?SGtkUEd5d29CSlpCU29PcHlUbnJoczZ3bnN1Vy8wL2xydzl0MjJkbm55VHBD?=
 =?utf-8?B?WWo3cnpDcHhEQVJJdFFYSXJyOFlrTkh0bzl3NnJ0ZzlFaGRBcDc3TjA2WE1H?=
 =?utf-8?B?YXlyTzZqL3ljYlpPVDlURzJxQ201WU5XZi83Z3o4Y25xM09XMndXdHVoVDNu?=
 =?utf-8?B?eTdsWVdZMjR6N2VNYnhoUkoweXVPL2dBM0ptbGo5d3hJdlE0YVE4VUJSS1N1?=
 =?utf-8?B?VGRUN29rZ21QWFpzbUlrQnRNMGVyTTgzdDU4VWVPSjJIQWtNQndVVk15ckxU?=
 =?utf-8?B?NTU5d3M2Q08rcUJMOEQybEVYU1hzRVNUb3B3TzQvckRrV2MzSW0vb2xTK0Fq?=
 =?utf-8?B?NCtkZ3oydUJ5czYySnc5VGh0ZWdZOGhtVXhoOU9xNDluV1VlL0lOOUdENnkv?=
 =?utf-8?B?d0hnbHBqbzEvdjJ4VTRuWmdIS0czTjJka2xsUlRqQy9zNUF2YitWL3J1cnRH?=
 =?utf-8?B?eUNYM2dsREU0Rm9PNUl3SlpGeEtvTVdXeFA0VlJlTjdTdGV4b1VYZjVlUGRU?=
 =?utf-8?B?SW9qUTlBNFlsM0ZFbGJWV3diM0NsMkhZWUZ1YlNQTC9Hc1VZMXFKZUE1Wlcz?=
 =?utf-8?B?N0NCa1dYdEZOVW5rZmtqOWVTT2x2em0ybHoyVWwxVE5nQjlPcFFHc095b3Rn?=
 =?utf-8?B?WXcwTVp2TzZsWSs3ekNFSXVqUk9SeFpISkxJTmwrZWN4RGJRL1pvbmY1SjJT?=
 =?utf-8?B?YVE3YTF6TlZNWEs4SlBwZ2YvR29SL2orencyYWRuZ2RiM3RPc3F2STRHSWhR?=
 =?utf-8?B?VjBqSW1FQkxaazE5UXROMzYwRElqQlIzbi9MZ2FUcU9na3BuYTlucHMrcEdQ?=
 =?utf-8?B?Y05sMUxjMXJDd3YzTzRzelRacjh3Wm4rZzJrckRYdUp2c0w5a25tQVJ0Ukxp?=
 =?utf-8?B?RFl4SHJaUG5UOHUwcERUSkhVLzBMTEx3enBJdkwzcm96akUvNk04NFA2WVVE?=
 =?utf-8?B?TlVYR2JVQUhqUE5kMys3azgrWm1hYTZpSS9SUjJSUUVqajJTc1JZeXllK1A4?=
 =?utf-8?B?RzhSU3J3STEwWnMvVlhWaEQyNWFPdk50dkJFTzJDdFhoenJFbGc5eEpUWk8r?=
 =?utf-8?B?MkhaYWQzd2xONTl3Y1BkU2VrUW1TUVZ3Zk4rOWZJZU1vY0V1ZTRYSThwUkFt?=
 =?utf-8?Q?VcVcyvB4Y8gEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e1697-aaa7-4516-5f70-08d97850168f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 13:52:42.3106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7zaSXYQocBn26SAABhztcDVDi6Ny46A6IWXbRijYGSBoMVN784RT8BRNIsjPOuLpdrg+KGxJZuC6uBR7oMO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
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

On 2021-09-15 2:42 a.m., Pan, Xinhui wrote:
> [AMD Official Use Only]
>
> Andrey
> I hit panic with this plug/unplug test without this patch.


Can you please tell which ASIC you are using and which kernel branch and 
what is the tip commit ?


> But as we add enter/exit in all its callers. maybe it would not impact plug/unplug.


If you add enter/exit in all callers then why this solves the problem ? 
Is it because in one or more callers
amdgpu_gmc_set_pte_pde is called many times and so calling enter/exit 
many times creates the problematic
contention from multiple threads ?

Andrey

>
> [ 1109.041095] BUG: unable to handle page fault for address: 00000000000010e1
> [ 1109.086353] RIP: 0010:vega10_power_gate_vce+0x15/0x40 [amdgpu]
> [ 1109.196706] Call Trace:
> [ 1109.199374]  ? pp_set_powergating_by_smu+0x1f9/0x4a0 [amdgpu]
> [ 1109.205843]  amdgpu_dpm_set_powergating_by_smu+0xa6/0x150 [amdgpu]
> [ 1109.212776]  amdgpu_dpm_enable_vce+0x36/0x100 [amdgpu]
> [ 1109.218563]  vce_v4_0_hw_fini+0xe1/0xf0 [amdgpu]
> [ 1109.223747]  amdgpu_device_fini_hw+0x333/0x483 [amdgpu]
> [ 1109.229650]  amdgpu_driver_unload_kms+0x80/0xe0 [amdgpu]
> [ 1109.235577]  amdgpu_pci_remove+0x37/0x70 [amdgpu]
> [ 1109.240853]  pci_device_remove+0x3b/0xb0
> [ 1109.245127]  device_release_driver_internal+0x100/0x1d0
> [ 1109.250857]  device_release_driver+0x12/0x20
> [ 1109.255535]  pci_stop_bus_device+0x79/0xa0
> [ 1109.260016]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
> [ 1109.266197]  remove_store+0x7b/0x90
> [ 1109.269990]  dev_attr_store+0x14/0x30
> [ 1109.274002]  sysfs_kf_write+0x48/0x60
> [ 1109.277998]  kernfs_fop_write_iter+0x14e/0x1e0
>
> ________________________________________
> 发件人: Pan, Xinhui <Xinhui.Pan@amd.com>
> 发送时间: 2021年9月15日 14:37
> 收件人: amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander; Koenig, Christian; Grodzovsky, Andrey; Pan, Xinhui
> 主题: [PATCH v2] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
>
> We hit soft hang while doing memory pressure test on one numa system.
> After a qucik look, this is because kfd invalid/valid userptr memory
> frequently with process_info lock hold.
> Looks like update page table mapping use too much cpu time.
>
> perf top says below,
> 75.81%  [kernel]       [k] __srcu_read_unlock
>   6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
>   3.56%  [kernel]       [k] __srcu_read_lock
>   2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
>   2.20%  [kernel]       [k] __sg_page_iter_dma_next
>   2.15%  [drm]          [k] drm_dev_enter
>   1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
>   1.18%  [kernel]       [k] __sg_alloc_table_from_pages
>   1.09%  [drm]          [k] drm_dev_exit
>
> So move drm_dev_enter/exit outside gmc code, instead let caller do it.
> They are gart_unbind, gart_map, vm_clear_bo, vm_update_pdes and
> gmc_init_pdb0. vm_bo_update_mapping already calls it.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
> change from v1:
> add enter/exit in more gmc_set_pte_pde callers
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 11 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 +++++++++++++++++-------
>   3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 76efd5f8950f..d7e4f4660acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -34,6 +34,7 @@
>   #include <asm/set_memory.h>
>   #endif
>   #include "amdgpu.h"
> +#include <drm/drm_drv.h>
>
>   /*
>    * GART
> @@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>          u64 page_base;
>          /* Starting from VEGA10, system bit must be 0 to mean invalid. */
>          uint64_t flags = 0;
> +       int idx;
>
>          if (!adev->gart.ready) {
>                  WARN(1, "trying to unbind memory from uninitialized GART !\n");
>                  return -EINVAL;
>          }
>
> +       if (!drm_dev_enter(&adev->ddev, &idx))
> +               return 0;
> +
>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>          p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>          for (i = 0; i < pages; i++, p++) {
> @@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>          for (i = 0; i < adev->num_vmhubs; i++)
>                  amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>
> +       drm_dev_exit(idx);
>          return 0;
>   }
>
> @@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   {
>          uint64_t page_base;
>          unsigned i, j, t;
> +       int idx;
>
>          if (!adev->gart.ready) {
>                  WARN(1, "trying to bind memory to uninitialized GART !\n");
>                  return -EINVAL;
>          }
>
> +       if (!drm_dev_enter(&adev->ddev, &idx))
> +               return 0;
> +
>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>
>          for (i = 0; i < pages; i++) {
> @@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>                          page_base += AMDGPU_GPU_PAGE_SIZE;
>                  }
>          }
> +       drm_dev_exit(idx);
>          return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 54f059501a33..1427fd70310c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -153,10 +153,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   {
>          void __iomem *ptr = (void *)cpu_pt_addr;
>          uint64_t value;
> -       int idx;
> -
> -       if (!drm_dev_enter(&adev->ddev, &idx))
> -               return 0;
>
>          /*
>           * The following is for PTE only. GART does not have PDEs.
> @@ -165,8 +161,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>          value |= flags;
>          writeq(value, ptr + (gpu_page_idx * 8));
>
> -       drm_dev_exit(idx);
> -
>          return 0;
>   }
>
> @@ -752,6 +746,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>                  adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>          u64 vram_end = vram_addr + vram_size;
>          u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> +       int idx;
> +
> +       if (!drm_dev_enter(&adev->ddev, &idx))
> +               return;
>
>          flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
>          flags |= AMDGPU_PTE_WRITEABLE;
> @@ -773,6 +771,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>          flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
>          /* Requires gart_ptb_gpu_pa to be 4K aligned */
>          amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
> +       drm_dev_exit(idx);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0126ece898da..daa16d2f89da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -800,7 +800,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>          struct amdgpu_bo *bo = &vmbo->bo;
>          unsigned entries, ats_entries;
>          uint64_t addr;
> -       int r;
> +       int r, idx;
>
>          /* Figure out our place in the hierarchy */
>          if (ancestor->parent) {
> @@ -845,9 +845,12 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>                          return r;
>          }
>
> +       if (!drm_dev_enter(&adev->ddev, &idx))
> +               return -ENODEV;
> +
>          r = vm->update_funcs->map_table(vmbo);
>          if (r)
> -               return r;
> +               goto exit;
>
>          memset(&params, 0, sizeof(params));
>          params.adev = adev;
> @@ -856,7 +859,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>
>          r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
>          if (r)
> -               return r;
> +               goto exit;
>
>          addr = 0;
>          if (ats_entries) {
> @@ -872,7 +875,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>                  r = vm->update_funcs->update(&params, vmbo, addr, 0, ats_entries,
>                                               value, flags);
>                  if (r)
> -                       return r;
> +                       goto exit;
>
>                  addr += ats_entries * 8;
>          }
> @@ -895,10 +898,13 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>                  r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>                                               value, flags);
>                  if (r)
> -                       return r;
> +                       goto exit;
>          }
>
> -       return vm->update_funcs->commit(&params, NULL);
> +       r = vm->update_funcs->commit(&params, NULL);
> +exit:
> +       drm_dev_exit(idx);
> +       return r;
>   }
>
>   /**
> @@ -1384,11 +1390,14 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                            struct amdgpu_vm *vm, bool immediate)
>   {
>          struct amdgpu_vm_update_params params;
> -       int r;
> +       int r, idx;
>
>          if (list_empty(&vm->relocated))
>                  return 0;
>
> +       if (!drm_dev_enter(&adev->ddev, &idx))
> +               return -ENODEV;
> +
>          memset(&params, 0, sizeof(params));
>          params.adev = adev;
>          params.vm = vm;
> @@ -1396,7 +1405,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>
>          r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
>          if (r)
> -               return r;
> +               goto exit;
>
>          while (!list_empty(&vm->relocated)) {
>                  struct amdgpu_vm_bo_base *entry;
> @@ -1414,10 +1423,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>          r = vm->update_funcs->commit(&params, &vm->last_update);
>          if (r)
>                  goto error;
> +       drm_dev_exit(idx);
>          return 0;
>
>   error:
>          amdgpu_vm_invalidate_pds(adev, vm);
> +exit:
> +       drm_dev_exit(idx);
>          return r;
>   }
>
> --
> 2.25.1
>
