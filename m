Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA14EC19F2B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 21:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA1B18B8D3;
	Wed,  3 Aug 2022 21:02:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932C118B95C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 21:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwVIBdROJL3UTqPdBtBQ04eVRKoyYI5IHEGGsXr5orBebgm3Ps44Xh9oPqqqb0gwynCrxRKOJTzN+KI/5oPmZME3op7LLen8ULNR+4iyvhN2CtNBsH6EwkYnfjywT/QLEU+1A0iE3AwwQn7snv2z5RQ1Qlm7O1bYIGC1ixGqidIDShhSWuwh096I5YeXrzOi/h+C5ZPLMbFqEGEaSCiwGXxx0AUcVMctijTRcqRLfOdMzDg9fvFtDclRXye1yQwMO6ARQQG2jJlIgoZmYYGzAF2cluBJgV8WKc/8vUBBni8DWTLIHkaeU3dyn2xTehG2RJJf2F/B3+y1fv6a4MDorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSKRmhi2SiQkS+LKc/2IwrilHyXyX2ls/N1zWo/WCQc=;
 b=UABLK1si6yJbH2MiF/gBFB2EbYeTXn9Tuf+OxNXJQx38sMvOagGaGc/AqFLeW4dDHzfRmBg6bwzvgOkBeqhi+OWY7xsjIDHmlUtlP4BrpYuFRtxI4vY9a0YnKQcx5JBi0VrA92ikzd6UCwilbQnmeR7NTs03krsdhdgWo2ZkgTfEAG4rug7Wu5j9gBvZ7iGEBO06IlWYq2pNUJv8Q69AJqWp4C+nL+/8A0V105ZtJu8GjS1sW3a4TD27WzT/lEx7W6WOeT6RbXQXNZhUKBtB0i++5FYWwz4QIuejMN7rUp9h5Prg/1H5CyaDsrC9rW8sN2AVOgwroy19/DfkHLORWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSKRmhi2SiQkS+LKc/2IwrilHyXyX2ls/N1zWo/WCQc=;
 b=XxSAUnoD79XTRRWzn22MHTCTtGK4agnAe/1rRxObkq09He2/uZgrsBr+g/Z6TaJgdEbjM5xESymATmTfF+uwkWhQYSwaBJF6wPHqT3W/9sTvc/zz6Ajb/HhOLN7UUS98as7D7aa388vnWOI1YQCyGgQ0hjPuS1ttRwX8Gjvk/qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 21:02:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 21:02:44 +0000
Message-ID: <8dc0719d-a4df-7521-0d88-afad3acb5809@amd.com>
Date: Wed, 3 Aug 2022 17:02:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, sungjoon.kim@amd.com, nikola.cornij@amd.com
References: <20220803162402.3412968-1-mwen@igalia.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220803162402.3412968-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83c1bcf-7ac3-4bec-0b9a-08da759382e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aDRiRlSj+wOdawEC/rE1W27NDmDyccMQ1snozKfZX8UHElaf1So9qqaj22UcgaPGPf0tEfyHqV9dOV3iy1gK2JoGjsG4wulf/1pgWQ3tb4buNUfNiZHldy485UBuQYMgXsZZo8/k+a5Alfi7XjXeAUyBi1XjXYc3dlbQQhMuPdWrXFYY/O8cmUT/o/LUX/Zw7Gwy0vtukOFlH15b7qvJ/yz7W0Sn2B4mdOVMDVrhd/YSKo5KsJpyPbeLcpRu1oJ9lHxev+JLyqGv8j6e6NA/jNDHILrc3c4a2ath682MfWqCjwbtVdg4qYarq6y3tUgVo9ue1lT/ZzRkZ4b2NWzEEnmOONUv69ywq/6IatWGxEEFSVMWHZhbfWJR5FJ8k2PWbYmAdvZWVzEjMVJhfs2BgF9C9HIyddVr7l1/8RHCsi8ba2+drWfCWKiI5B9LBtYlfIReCNKiy4AiSrdFKL924gWUqQ0WkDaUz62NUxfYxOhzChzyrRuXg0izLDTRXVV7X8v0ZmQAbqFJUgASX2mLTFwR7gIdR8FroewLMiwDMsrf6XEee0R1MQO889oliRdhHcYvXglIiHjAeC5Y89sjc5dfxuxFi5D+36tisXNXdziiyjV7NbZpxJnhFDBZOVPH/okF5XR5riW87RcmewLlJayRGRPrle+b2RfCnmTR1BLRisY88VNfzEvRcOqEL8TX1A2dREGqUpGAHKsVInzOAj+wAWZY7CpvNNkKCdoN7OFnOkOFuuPC2fLQ7tSqdhaE2JBe5JU4w3BO/iZHES50Xumh+xInMw5XPc+3j9+d6eDk2SlWz12H1dXRQPuCWPXLT5vZy68E/oLyo/RRFv1YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(31696002)(6506007)(6666004)(26005)(41300700001)(6512007)(53546011)(45080400002)(6636002)(110136005)(478600001)(6486002)(316002)(38100700002)(86362001)(83380400001)(30864003)(44832011)(186003)(2906002)(66556008)(8936002)(66946007)(66476007)(31686004)(5660300002)(4326008)(8676002)(36756003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnB1YW9Dc2c2VC9XQ2ZRSmVDMUY1K1Q5OFpPR3YxZmRuSXFHc3JyQk5XeFFn?=
 =?utf-8?B?WnU5UXk4ZTk3Y2ZrOGsxbzM4UmE5UytwYUEzQUdnQmJKd2VWcFMzTGF6SC9o?=
 =?utf-8?B?VTc3RnVVSHVlVkZSWUdHZGQwd1h0a1didkZsbENoN2drVEV6d3pJd3djaSs2?=
 =?utf-8?B?M0JpdkRXVTlpelFVaUNEVWNOYkRJb1FVVmIybktRbjhWazdDREJ4blladFFK?=
 =?utf-8?B?dVdOSjRmS1QyUVArdEVNV2I4cVZuRnJCbW5aQ2tqZ2ZoU3dHVTRkV0ZhejQ4?=
 =?utf-8?B?b0Y1TUR6dytHbmhVaGhZczJaS0QrZTYrYjdiTmUweTFKRjg2OVk2eDc3T1FH?=
 =?utf-8?B?VVg2L0o3QStrZHFMMVNFdGNTUit3WjBPZUo2RmRyTjRxOTRBUCtqWDJRaEdK?=
 =?utf-8?B?QVJBcWpPbkpTV1FodzJJV3lmS3NNZi8rR24veE8yaU82cm9ta1BTWG96OGdv?=
 =?utf-8?B?RGNCZGlSVDBrdGhBaU50SEE0aEl6WEhocjZpRHNCSUZZelQyREIyaDVNQWlY?=
 =?utf-8?B?L1hmZUZLcU5kWnh4YzIxa3NkQndYSmU2TWVteW5ZSjA2RGkvV1ZRL3V2UTE2?=
 =?utf-8?B?RUkvUFlJcjE0enVhRDNEQmY5WWZQdnU2S3F3VDYrcHRZWG5ldHZXSFRRSGZl?=
 =?utf-8?B?Wlk3c1NpKzloUGN4bXlJb3Y5ejVLWTF5RW1xaElIQkY1RFBRN2hWeXJwOHA1?=
 =?utf-8?B?UW90b1dWR0VyT1FGN0FGSldoTlVxOCtxZ3ZMTWhzMWdJN3RSUCtvL0M5eXg5?=
 =?utf-8?B?cUd5WjNUeGxwUWhsc0pYN2I5VEN1QkFjTldrTmtaQVdaQmdReU11TzYrd3N2?=
 =?utf-8?B?SkptYU5DRWNtbmVXUWJyYXBHUFpqSGp2N1NXM09rVnhxTHk0eVp6VkxMeG96?=
 =?utf-8?B?NTg1VGFvMmtEajF6T2V1MmI4WmpLRXplWkJRR3pqek51bjZPeHl3Z2FVS0tG?=
 =?utf-8?B?S2FDRjhMZkM5eko3LzZZQXl5ZW4xL3JqZWxQcHhiU2J0U2pLaDQ1YlNmaXhC?=
 =?utf-8?B?WVZwRmZ5NU91NE9JSGl5YkZJYVZGNTNmYTl1MjJtaGRDc0tkdDBHeDZ1Wlo5?=
 =?utf-8?B?MFFuTGFITnk3Mm5BUGd4TVVQQUNGdE02bmVFMHhLUE9waXVRUjBQZEQrNGVD?=
 =?utf-8?B?b3pxRC94V0V6SEt1Wm4veVFueEN6SXJNSGFqaW04aXJMb2lxN0crd2l0Y3pz?=
 =?utf-8?B?RCtobG9GK3EvUjJmdUovU2xVSmp2d3dYeC9lWnV3Z2JZY1EyWGU4WFhhYmg4?=
 =?utf-8?B?RmNaTXJoZGVUT2xsRFUweHgxcVU0M3JaZ2hyZXA5YW1rejdyUCtnbHI0UFdS?=
 =?utf-8?B?c1pZYWxFQStocWJIVnRYc0JBemwxc0M4NGgrSzQwMWVpbTZPek1XMC90OUVD?=
 =?utf-8?B?dmFXV0pkVzgxeStjaHdPbm9nSllpbTNTbkdQdlYvUERFU2xUOTYyTlJFTklE?=
 =?utf-8?B?aEQxOHF3UmJJeW1XeFhuVnR0cjJzb3pyaXJqOHJHVkk1bnRYNkxPVUs5RUJM?=
 =?utf-8?B?SnFBamptN0NwL2R1ZFovblBNb1prcmNlTXFUM1UrSXdoRk42ekczUG5EaWxr?=
 =?utf-8?B?TkcyQ0lYZDFZQzljeENtTndQbG1jZUU2TStMYW4yQ21DcVVCNXZpZHVJeUhC?=
 =?utf-8?B?OGgwSUJFTldZU1U5dkg4NkVuWldRUEJRQjFFVG9kM0lVZnRVZmZpM1RoUklS?=
 =?utf-8?B?V0lHS25JVGg2TnZ1bzgyYVlWZWJBZ1VsRzBVNXY0bzJOcVlHaGliRmt0NWhN?=
 =?utf-8?B?Y3RkR0I4UUY2N1FmV2RHQys0Vk1va3oxa04zZm9pV0xmeTl3bzZaQUh5YXIy?=
 =?utf-8?B?cU9WYmFwTFdYK2JFcGFQVmdhS0IrWjF0Mks4c283QTVodGgxeW9jclk1Y0Zx?=
 =?utf-8?B?THZHckF3ZUg4VjIraGVKOUR2QVc0bHFUb2xEVm1IOHNOYjNhbzhRU1pUNklO?=
 =?utf-8?B?S0c4WUwyWk1vbE0wQkdRdktpQWphMG9DcHpuNUlzZ2NWZ3k1WFpzT21BZDdY?=
 =?utf-8?B?aWg5a3h5Ylh3ZzVsM2xoQjdpQWxRdUREcEUraTFiM1pSejRCN2s3ZGU1ZXRD?=
 =?utf-8?B?NTZjWE0vV0ExdGxSVHYwM1JUWTRXTGdWWmZucUttUm1NbVp1ZGJyMk1PRGNi?=
 =?utf-8?Q?7QzJhgAu3eSyrtkVjBv0Gu0uS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83c1bcf-7ac3-4bec-0b9a-08da759382e5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 21:02:44.5537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIxO8b+XdZ5YkSKrrycdpp1iT6aiTbFcDE+pYH62XQqj3110qkrgaCrVPu6pUFX0hCXD2si8irkx+vtCitROrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
Cc: kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-08-03 12:24, Melissa Wen wrote:
> To set the panel orientation property with quirk, we need the mode size
> provided by EDID. This info is available after EDID is read by dc_link_detect()
> and updated by amdgpu_dm_update_connector_after_detect(). The detection
> happens at driver load in amdgpu_dm_initialize_drm_device() and,
> therefore, we can get modes and set panel orientation before
> drm_dev_register() to avoid DRM warns on creating the connector property
> after device registration:
> 
> [    2.563969] ------------[ cut here ]------------
> [    2.563971] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_object.c:45 drm_mode_object_add+0x72/0x80 [drm]
> [    2.563997] Modules linked in: btusb btrtl btbcm btintel btmtk bluetooth rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgart gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vivaldi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch ghash_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq dm_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
> [    2.564032] CPU: 6 PID: 325 Comm: systemd-udevd Not tainted 5.18.0-amd-staging-drm-next+ #67
> [    2.564034] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2022
> [    2.564036] RIP: 0010:drm_mode_object_add+0x72/0x80 [drm]
> [    2.564053] Code: f0 89 c3 85 c0 78 07 89 45 00 44 89 65 04 4c 89 ef e8 e2 99 04 f1 31 c0 85 db 0f 4e c3 5b 5d 41 5c 41 5d c3 80 7f 50 00 74 ac <0f> 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 4c
> [    2.564055] RSP: 0018:ffffb2e880413860 EFLAGS: 00010202
> [    2.564056] RAX: ffffffffc0ba1440 RBX: ffff99508a860010 RCX: 0000000000000001
> [    2.564057] RDX: 00000000b0b0b0b0 RSI: ffff99508c050110 RDI: ffff99508a860010
> [    2.564058] RBP: ffff99508c050110 R08: 0000000000000020 R09: ffff99508c292c20
> [    2.564059] R10: 0000000000000000 R11: ffff99508c0507d8 R12: 00000000b0b0b0b0
> [    2.564060] R13: 0000000000000004 R14: ffffffffc068a4b6 R15: ffffffffc068a47f
> [    2.564061] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlGS:0000000000000000
> [    2.564063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.564063] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 0000000000350ee0
> [    2.564065] Call Trace:
> [    2.564068]  <TASK>
> [    2.564070]  drm_property_create+0xc9/0x170 [drm]
> [    2.564088]  drm_property_create_enum+0x1f/0x70 [drm]
> [    2.564105]  drm_connector_set_panel_orientation_with_quirk+0x96/0xc0 [drm]
> [    2.564123]  get_modes+0x4fb/0x530 [amdgpu]
> [    2.564378]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_kms_helper]
> [    2.564390]  drm_client_modeset_probe+0x229/0x1400 [drm]
> [    2.564411]  ? xas_store+0x52/0x5e0
> [    2.564416]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.564420]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm_kms_helper]
> [    2.564430]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
> [    2.564438]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
> [    2.564446]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
> [    2.564621]  local_pci_probe+0x45/0x80
> [    2.564625]  ? pci_match_device+0xd7/0x130
> [    2.564627]  pci_device_probe+0xbf/0x220
> [    2.564629]  ? sysfs_do_create_link_sd+0x69/0xd0
> [    2.564633]  really_probe+0x19c/0x380
> [    2.564637]  __driver_probe_device+0xfe/0x180
> [    2.564639]  driver_probe_device+0x1e/0x90
> [    2.564641]  __driver_attach+0xc0/0x1c0
> [    2.564643]  ? __device_attach_driver+0xe0/0xe0
> [    2.564644]  ? __device_attach_driver+0xe0/0xe0
> [    2.564646]  bus_for_each_dev+0x78/0xc0
> [    2.564648]  bus_add_driver+0x149/0x1e0
> [    2.564650]  driver_register+0x8f/0xe0
> [    2.564652]  ? 0xffffffffc1023000
> [    2.564654]  do_one_initcall+0x44/0x200
> [    2.564657]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.564659]  do_init_module+0x4c/0x250
> [    2.564663]  __do_sys_init_module+0x12e/0x1b0
> [    2.564666]  do_syscall_64+0x3b/0x90
> [    2.564670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.564673] RIP: 0033:0x7fc69bff232e
> [    2.564674] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
> [    2.564676] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [    2.564677] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69bff232e
> [    2.564678] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc699e4d010
> [    2.564679] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 0000000001155e90
> [    2.564680] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873f7bf390
> [    2.564681] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873f797820
> [    2.564683]  </TASK>
> [    2.564683] ---[ end trace 0000000000000000 ]---
> [    2.564696] ------------[ cut here ]------------
> [    2.564696] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_object.c:242 drm_object_attach_property+0x52/0x80 [drm]
> [    2.564717] Modules linked in: btusb btrtl btbcm btintel btmtk bluetooth rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgart gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vivaldi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch ghash_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq dm_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
> [    2.564738] CPU: 6 PID: 325 Comm: systemd-udevd Tainted: G        W         5.18.0-amd-staging-drm-next+ #67
> [    2.564740] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2022
> [    2.564741] RIP: 0010:drm_object_attach_property+0x52/0x80 [drm]
> [    2.564759] Code: 2d 83 f8 18 74 33 48 89 74 c1 08 48 8b 4f 08 48 89 94 c1 c8 00 00 00 48 8b 47 08 83 00 01 c3 4d 85 d2 75 dd 83 7f 58 01 75 d7 <0f> 0b eb d3 41 80 78 50 00 74 cc 0f 0b eb c8 44 89 ce 48 c7 c7 28
> [    2.564760] RSP: 0018:ffffb2e8804138d8 EFLAGS: 00010246
> [    2.564761] RAX: 0000000000000010 RBX: ffff99508c1a2000 RCX: ffff99508c1a2180
> [    2.564762] RDX: 0000000000000003 RSI: ffff99508c050100 RDI: ffff99508c1a2040
> [    2.564763] RBP: 00000000ffffffff R08: ffff99508a860010 R09: 00000000c0c0c0c0
> [    2.564763] R10: 0000000000000000 R11: 0000000000000020 R12: ffff99508a860010
> [    2.564764] R13: ffff995088733008 R14: ffff99508c1a2000 R15: ffffffffc068a47f
> [    2.564765] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlGS:0000000000000000
> [    2.564766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.564767] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 0000000000350ee0
> [    2.564768] Call Trace:
> [    2.564769]  <TASK>
> [    2.564770]  drm_connector_set_panel_orientation_with_quirk+0x4a/0xc0 [drm]
> [    2.564789]  get_modes+0x4fb/0x530 [amdgpu]
> [    2.565024]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_kms_helper]
> [    2.565036]  drm_client_modeset_probe+0x229/0x1400 [drm]
> [    2.565056]  ? xas_store+0x52/0x5e0
> [    2.565060]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.565062]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm_kms_helper]
> [    2.565072]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
> [    2.565080]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
> [    2.565088]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
> [    2.565261]  local_pci_probe+0x45/0x80
> [    2.565263]  ? pci_match_device+0xd7/0x130
> [    2.565265]  pci_device_probe+0xbf/0x220
> [    2.565267]  ? sysfs_do_create_link_sd+0x69/0xd0
> [    2.565268]  really_probe+0x19c/0x380
> [    2.565270]  __driver_probe_device+0xfe/0x180
> [    2.565272]  driver_probe_device+0x1e/0x90
> [    2.565274]  __driver_attach+0xc0/0x1c0
> [    2.565276]  ? __device_attach_driver+0xe0/0xe0
> [    2.565278]  ? __device_attach_driver+0xe0/0xe0
> [    2.565279]  bus_for_each_dev+0x78/0xc0
> [    2.565281]  bus_add_driver+0x149/0x1e0
> [    2.565283]  driver_register+0x8f/0xe0
> [    2.565285]  ? 0xffffffffc1023000
> [    2.565286]  do_one_initcall+0x44/0x200
> [    2.565288]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.565290]  do_init_module+0x4c/0x250
> [    2.565291]  __do_sys_init_module+0x12e/0x1b0
> [    2.565294]  do_syscall_64+0x3b/0x90
> [    2.565296]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.565297] RIP: 0033:0x7fc69bff232e
> [    2.565298] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
> [    2.565299] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [    2.565301] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69bff232e
> [    2.565302] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc699e4d010
> [    2.565303] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 0000000001155e90
> [    2.565303] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873f7bf390
> [    2.565304] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873f797820
> [    2.565306]  </TASK>
> [    2.565307] ---[ end trace 0000000000000000 ]---
> 
> Fixes: d77de7880e0e0 ("amd/display: enable panel orientation quirks")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0d54c1486739..c2806695589a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4133,6 +4133,7 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
>  	}
>  }
>  
> +static void amdgpu_set_panel_orientation(struct amdgpu_dm_connector *aconnector);
>  
>  /*
>   * In this architecture, the association
> @@ -4324,6 +4325,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  					adev_to_drm(adev)->vblank_disable_immediate = false;
>  			}
>  		}
> +		amdgpu_set_panel_orientation(aconnector);
>  	}
>  
>  	/* Software is initialized. Now we can register interrupt handlers. */
> @@ -6672,16 +6674,28 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
>  	}
>  }
>  
> -static void amdgpu_set_panel_orientation(struct drm_connector *connector)
> +static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
> +					      struct edid *edid);
> +
> +static void amdgpu_set_panel_orientation(struct amdgpu_dm_connector *aconnector)
>  {
>  	struct drm_encoder *encoder;
> +	struct drm_connector *connector = &aconnector->base;
>  	struct amdgpu_encoder *amdgpu_encoder;
>  	const struct drm_display_mode *native_mode;
> +	struct edid *edid = aconnector->edid;
>  
>  	if (connector->connector_type != DRM_MODE_CONNECTOR_eDP &&
>  	    connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
>  		return;
>  
> +	if (!drm_edid_is_valid(edid))
> +		return;
> +
> +	mutex_lock(&connector->dev->mode_config.mutex);
> +	amdgpu_dm_connector_ddc_get_modes(connector, edid);

Might be best to call amdgpu_dm_connector_get_modes which initializes
all modes. This will likely get called anyways later but I would hate
if this lead to confusion when people debug this code later.

Harry

> +	mutex_unlock(&connector->dev->mode_config.mutex);
> +
>  	encoder = amdgpu_dm_connector_to_encoder(connector);
>  	if (!encoder)
>  		return;
> @@ -6726,8 +6740,6 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>  		 * restored here.
>  		 */
>  		amdgpu_dm_update_freesync_caps(connector, edid);
> -
> -		amdgpu_set_panel_orientation(connector);
>  	} else {
>  		amdgpu_dm_connector->num_modes = 0;
>  	}

