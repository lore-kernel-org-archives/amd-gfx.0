Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B99CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 01:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9E310E23F;
	Thu, 12 Oct 2023 01:59:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D6710E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 01:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flFR6U4cyoUz8jhli7rZigA85ihc217EspYxgM1nSXRCaG14G75ljw/XcZTYcc6nDheCAw8D6lrJNs93pe6BPthQGmwUPtGAfGvwG3xqkbUPOKofzmdFngU5cTmig59BnYWEp5Tdi2kEw6wd3HRWsNmbPri4GgsSNMZfkrIuskPO+k7zLM/s9uYgFrN61Rgf5Z7XWrFaWAV0nbdH7uau5lpZ2l/wOaGSs67gCCVnQhC9V+C1AJaXReeXA0TtndcHL2jD3rYopk1NYzc8b5+wkkceh7FITaZhRal77BZFhZW8v7ck0UYA74PX0x+typ6Ak1dxdZqzfYZhA0zn7ZqzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auQfoqSvkGTB9WcLHOWuh23c8RJwmKQrwazsJ1/75Xo=;
 b=AADZPN67Vh6rqoTGkYqWtvhrs9CPGdrUFto5aOvIGCeu8MIGBYFXf5BQZ1vU03QmwRIr2Bl+MxZKQzLpjsmdrT6nTFotsE+MTgpV3rJJpD1xvpOkd5SmrYJ4YntMFvHJxPaEQEFLtow9rL73XIpCfFBtK8sUHM70Sf2D2OhA/J/bn/SHNiDD/Olo4FdbBBa5MI7vfEQGEreWuDSIBZc/0oDXhUMVOr8nlUmgZR0hnTA77x6QMlpry5cgvKcZdAJM+7Lh07h7XO4NHPtz3JDeE6BxABsmnBJiiLUdiUL1FsLwZjgidNTyCR8pAGFRagMOrVIhUd9P4ZDpSRbwKhBeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auQfoqSvkGTB9WcLHOWuh23c8RJwmKQrwazsJ1/75Xo=;
 b=G4ASqrzvVhr6Qq+2aq801qrADiOMS8kcQfPPW6Y/8iulZk6PNkAlbWq2kcMNfasnrwb1SnJeatRaz4i2QUHhNPKqb2JwlXAqkjADt7dji1LAuZoIyKT32GVWPYObFuf5WIKiqOAzBAmI5ZfNc0qTQPubvn2BpjgCPViWQgX1Tpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Thu, 12 Oct
 2023 01:59:24 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 01:59:24 +0000
Message-ID: <b7a3ff16-cacf-4322-aeb0-d38ebda55b6b@amd.com>
Date: Wed, 11 Oct 2023 21:59:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.3.2
Subject: Re: [PATCH] drm/amdgpu: fix software pci_unplug on some chips
Content-Language: en-CA, en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
References: <20231012013148.207757-1-vitaly.prosyak@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20231012013148.207757-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::24) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ced469a-4199-4b25-4c3e-08dbcac6dbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+j8QkN3PXHZlMT45qntix+w6Eymp3PAzpHUFtnVr9qeziCRbwAKZLX+JOjugG9tyF03Qs0W7JfQiYBmbOPW3wdMw9WrnmiCxCzLInwSeO8rk3MX798Zc9j6v2ot8RPBqZD7aRcOcyuYMCecJgm5xtHjspegcu2lIzpGtPBfJCSH2w/kGZFpzow8xPhafMMGzhFgcCKCxkb9SBadd2xMETxuzeFZjXzhuKbxXicxrqywfMA5zbA1jgz3V78uGaahBrzN0YEq8/lD9D80XI0YM87aDk2KedpgZ4z0aW6sPd/gEYsmItfaUJnRGWpxl0ocHO31VcctBIXinUnY6Y4HmLmbtRknE+7SI6yYW46EHs7UHEK7z/LUiSomuEOLDMvOxZHSyUsXX6iWGBS2vs5aXlQ7iH8L/NXCyhjeac5HF/Oe4cyd7VpT4ibS4BrUdUDjZXJ4NuCPjelrEjhtRWu+af+OQCWLFvqzAiAm3J1fNAMAZ3mUi3gifn+603KIaZ36p+pV7xPRL+z2T43EPdbwqzu4qoHTYVkfQ6/FNjI8Fyr5LIVd2TwZa8TCfBZ5j5QN8OUMnufvOlwkZDEKtnCVkfD0e+ysihn94t1qlw5IDn3FCyg3cTB/O+3HmvaVMmmAnM4Zy/foBA6ztmnGQMzrhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2616005)(2906002)(6506007)(6512007)(4001150100001)(53546011)(31696002)(38100700002)(86362001)(26005)(83380400001)(5660300002)(54906003)(44832011)(8936002)(4326008)(8676002)(6486002)(478600001)(36756003)(316002)(41300700001)(31686004)(66476007)(66556008)(6666004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5rZitPT3FDUCtJMXUxbDNCMlJTKy9tRkowR2UyNS9DV04rT2s5djVMYlpB?=
 =?utf-8?B?dzJFNm9SbjlKVHlOV3FFU2hHVG03Zk1QOGRUb085cTZmL0FtTVZWdlpBcjNM?=
 =?utf-8?B?cDBnVjZuOFlUM2l3K0xGTnEyOHJZR0RaZG95WEVZMHlSZkRpcGZ2V1JldkRC?=
 =?utf-8?B?aUlxY1V4bW4yZFo2SkNjbUhmbXc5M1JCV1pXUjI4bHlSUW9nSm1xSnY5alVn?=
 =?utf-8?B?NWozaEtKVnZyUzBwUjR1eUNFRS9mYSsrQVBhRWdsKzY3eXFNWk1BeStrWG15?=
 =?utf-8?B?TmZRMzJ1UEUveVBHY1E4S0wrbG9aQVlYRFUwUWNqdzFZMm5YZEJBdW1BSWtn?=
 =?utf-8?B?RHBHMGVyRHl0ZzBQV0g5Mm8zaFgrYTVUNWwyKzBrb0Z1Tk40a0twL0dLU0lB?=
 =?utf-8?B?WGFLMFl5L3ZrWGhlRmFqd0hUSW9tNUJ6aFdqRmwxdmJjNktLNmoxOXNRanRD?=
 =?utf-8?B?TXlXRzRxVW9pVExYa3R6ZmJoTVFNWE9PRkxMTzV0VkUxVDRXTFBWMmJFYmRq?=
 =?utf-8?B?akEyM0lvYlhwSnpqYXZsUUxmQmJTZ0FQYWR4UmNCSy9FY1J0UXpUdU9hUnhm?=
 =?utf-8?B?b3VGK1dLRFBoVnd5QWI5RmQ0VlMrMmIxL25oOTBIUENPUDMwRk9zQ0t3TUpj?=
 =?utf-8?B?QXBYbWhmL0hOcDdmTThWaDRiMFRPZjkxTStoUDY1RTJaYWNvMURiK1hWa2hq?=
 =?utf-8?B?YnZuVG13Q1VwOHB1SEN4UXFiN2M4T2lySExzWkd0QUlNWk5KQ1M3Y1hXamFR?=
 =?utf-8?B?TlVuZEhlemhuVmsyOUdvKzI5aGVxUWp2dGNrajNkL0F2R2xRUENZSEFVcHhi?=
 =?utf-8?B?eU84bDVKd2RWNXF1UW14NUFhZzlaYVN2VEJNWHVnaG5YUTdPUTVDVmZlYmVx?=
 =?utf-8?B?UDdNZFQwNXo2aGhLRVo5SHFpN0JrTUx4ZE8zT1lIR1lVYTFpSHhGbG8xekhL?=
 =?utf-8?B?TW1kWkVyT1JsazU3aEN1emhWN2pHK2Z0a2RRY1dnT3EyVmdBMVBGZnp5WWJx?=
 =?utf-8?B?cjd2OGdtM2MrYlUzK3dWcWRiYnJob3dWWU9BMWRXWFcyK3c1ei9PZTBEdlZW?=
 =?utf-8?B?eGJabThNQ3hmYXN1Y08vQWVuVGR3cTRNcThpSkxHT3A3dEk1ZVJTZXpJQzdv?=
 =?utf-8?B?M1BBODBHVEhtenNNQS9mMHpNb0t0TXNIcWxyVFpvdHNDMDh3T0Z6UEp2Zms2?=
 =?utf-8?B?MFpRRkN3ODIwd2UydWt0M0tOdWNiSlEzb3BQK0o2QzVzdXR4bm5FS0NKUnNw?=
 =?utf-8?B?U3ZWR0VsOVlpSHoxTDllbTRuMHI0TDdGaXJDZldpdlAzRlZHcDR2eXdXcnRG?=
 =?utf-8?B?K3g5emNkTTd0M2VoOVFNa3NwRTdTQzdBNGwydXFER0NJOE03UXlycGZGb2I0?=
 =?utf-8?B?YnJqWGRJKzdHVHlyWWh2QUJ5NXp3c3ZvSjBUdTYxNW5TUmRvK3l1NW5pcTBo?=
 =?utf-8?B?d0VmY01ic3lPSFQ1ZVZZWEI1cktQbENyUlJESVRjdEl3MSs5UE90aFlhQ0JY?=
 =?utf-8?B?bHFXTmhKTkRSdG9qRGE4czJ6d1NIcnVkeElGWHJGTjJ0c2x1TVJPR0VXRy9Y?=
 =?utf-8?B?ei9aRlR6bk1CV1ZyT3o0Um96V0ZWVFl4MThwTjVCSmk0R29Oa3R0Yzlualpz?=
 =?utf-8?B?THUxakNGQXpZeU1kakRvYVU2Qzd5WkFHQ0tHWEVPZVZycHBnVWxhY096RVht?=
 =?utf-8?B?QStEdk5LY1poVEZBT3ZIbUVuWC9lWSt4Vlp1dEY5cnYybFVMbVJzMkRUbHBz?=
 =?utf-8?B?YTAvV0xVRkszV1JzTXg0Skp1Wnc4TmpNV0hJRVZsMUtwaXlzL2hxL1pZQ28y?=
 =?utf-8?B?c1dwdVFTam1udUZVNXZxSkJqVkNBV2g0MFZXNEFrZEdUYkdNMXlZSFRYaUhO?=
 =?utf-8?B?TVdyQnNGQmtNVEk5QnhzQm1LZVpYTXNsalhaZnRXeXU4a0NUalNjZVN0R3Ar?=
 =?utf-8?B?TUtLelFZSnorNlRaek9yMDZIL3FVMGttMmpWRWM0QjYxak1SL09oempRN1gw?=
 =?utf-8?B?eUNJMDJJRkg0c0hTRU1VZmxPaGo5VUxBTEJpSGhVbzFUT1ZWcjF4UGgvd2Jm?=
 =?utf-8?B?blpWQWhMbVQrcWFmUU0zR1hXdk9DSytmc2kwM3M5RjJHcTNkbjhSb3pqbkMz?=
 =?utf-8?Q?/E7euIbRccPH6Jzd33r6CSxam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced469a-4199-4b25-4c3e-08dbcac6dbf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 01:59:24.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHVm3EIe5sWa0sqIVTXs1eTtHk05qKD5Ux0PFUMZJzaD/z/xgpU8qegbTqqKI8ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-11 21:31, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> When software 'pci unplug' using IGT is executed we got a sysfs directory
> entry is NULL for differant ras blocks like hdp, umc, etc.
> Before call 'sysfs_remove_file_from_group' and 'sysfs_remove_group'
> check that 'sd' is  not NULL.
> 
> [  +0.000001] RIP: 0010:sysfs_remove_group+0x83/0x90
> [  +0.000002] Code: 31 c0 31 d2 31 f6 31 ff e9 9a a8 b4 00 4c 89 e7 e8 f2 a2 ff ff eb c2 49 8b 55 00 48 8b 33 48 c7 c7 80 65 94 82 e8 cd 82 bb ff <0f> 0b eb cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
> [  +0.000001] RSP: 0018:ffffc90002067c90 EFLAGS: 00010246
> [  +0.000002] RAX: 0000000000000000 RBX: ffffffff824ea180 RCX: 0000000000000000
> [  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  +0.000001] RBP: ffffc90002067ca8 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  +0.000001] R13: ffff88810a395f48 R14: ffff888101aab0d0 R15: 0000000000000000
> [  +0.000001] FS:  00007f5ddaa43a00(0000) GS:ffff88841e800000(0000) knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000001] CR2: 00007f8ffa61ba50 CR3: 0000000106432000 CR4: 0000000000350ef0
> [  +0.000001] Call Trace:
> [  +0.000001]  <TASK>
> [  +0.000001]  ? show_regs+0x72/0x90
> [  +0.000002]  ? sysfs_remove_group+0x83/0x90
> [  +0.000002]  ? __warn+0x8d/0x160
> [  +0.000001]  ? sysfs_remove_group+0x83/0x90
> [  +0.000001]  ? report_bug+0x1bb/0x1d0
> [  +0.000003]  ? handle_bug+0x46/0x90
> [  +0.000001]  ? exc_invalid_op+0x19/0x80
> [  +0.000002]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000003]  ? sysfs_remove_group+0x83/0x90
> [  +0.000001]  dpm_sysfs_remove+0x61/0x70
> [  +0.000002]  device_del+0xa3/0x3d0
> [  +0.000002]  ? ktime_get_mono_fast_ns+0x46/0xb0
> [  +0.000002]  device_unregister+0x18/0x70
> [  +0.000001]  i2c_del_adapter+0x26d/0x330
> [  +0.000002]  arcturus_i2c_control_fini+0x25/0x50 [amdgpu]
> [  +0.000236]  smu_sw_fini+0x38/0x260 [amdgpu]
> [  +0.000241]  amdgpu_device_fini_sw+0x116/0x670 [amdgpu]
> [  +0.000186]  ? mutex_lock+0x13/0x50
> [  +0.000003]  amdgpu_driver_release_kms+0x16/0x40 [amdgpu]
> [  +0.000192]  drm_minor_release+0x4f/0x80 [drm]
> [  +0.000025]  drm_release+0xfe/0x150 [drm]
> [  +0.000027]  __fput+0x9f/0x290
> [  +0.000002]  ____fput+0xe/0x20
> [  +0.000002]  task_work_run+0x61/0xa0
> [  +0.000002]  exit_to_user_mode_prepare+0x150/0x170
> [  +0.000002]  syscall_exit_to_user_mode+0x2a/0x50
> 
> Cc: Hawking Zhang <hawking.zhang@amd.com>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5fb57419ef77..1673a10835a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1390,7 +1390,8 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  
> -	sysfs_remove_file_from_group(&adev->dev->kobj,
> +	if (adev->dev->kobj.sd)
> +		sysfs_remove_file_from_group(&adev->dev->kobj,
>  				&con->badpages_attr.attr,
>  				RAS_FS_NAME);
>  }
> @@ -1409,7 +1410,8 @@ static int amdgpu_ras_sysfs_remove_dev_attr_node(struct amdgpu_device *adev)
>  		.attrs = attrs,
>  	};
>  
> -	sysfs_remove_group(&adev->dev->kobj, &group);
> +	if (adev->dev->kobj.sd)
> +		sysfs_remove_group(&adev->dev->kobj, &group);
>  
>  	return 0;
>  }
> @@ -1456,7 +1458,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
>  	if (!obj || !obj->attr_inuse)
>  		return -EINVAL;
>  
> -	sysfs_remove_file_from_group(&adev->dev->kobj,
> +	if (adev->dev->kobj.sd)
> +		sysfs_remove_file_from_group(&adev->dev->kobj,
>  				&obj->sysfs_attr.attr,
>  				RAS_FS_NAME);
>  	obj->attr_inuse = 0;

