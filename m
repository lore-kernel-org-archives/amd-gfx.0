Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED5EE14C3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 20:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5657C10E076;
	Wed,  6 Sep 2023 20:17:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B7D10E076
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 20:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7N7O+Bmyb04WLzkQu5t9CZ3mGac8+Hek5t9P7qWZIORLeUoGgqIOP1EqvvAU1E5FuneXG3ahor/g4/CBUzd5bXMjo/6ri7CPqppY2mPYRCMG4hDuSEL+5daf9RLvnLK0KmF/05DIqxTt/5k0fgS8+bjj07BHRTSKALzdjWlnw1fiVqIHtqdX2WRXXWaPvTIUr/zpOWcSy+6CUFI43Q2CYI3kQTpgLplQZQ0dZUoaRw2MMg+VngR8Mja8p/29N8PCZGdZ5JV1lpTatZE43xkpuTgS91JP0OAhWcQ6ei3QP1rOL/VxuwAPGVGxqlZ5MuWF5xB+oMAcDkWL1PUiYxm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swbhI2XFN1SZNx3HTsSdCn7lEsRM1aNpOGIkWVu/Cq4=;
 b=TKIl8tPKB5W0Kz5z2hG70SExDyQlr6IJCyw+qfGkMwab9f2JdE8Qypx3cY412s3OCeN0gcwi52MuEyeU4tj/pxDxfXN4d2RQXDAcWEEHEVnBE1iSlPkb9l80xS4WAjOU26pbaJkH9KkGTEj8pUBYloGwbYz7YKUnAPgln65r06/xParXq7Ne8fQX6SHme6DT8lP+kwOd7bAU9I3+uMiN25L9CFThYiBy7AYogM4BHfnSk/h0rWnyiTT42HT9v/aHSqEyHx4D7VJE2CWZJmBfDfYXL0DWtcRi4bXV/rct3ovfG+GYHa0JMGUMPLaLKix+LNnZfcjwnzcza+5atIqBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swbhI2XFN1SZNx3HTsSdCn7lEsRM1aNpOGIkWVu/Cq4=;
 b=HoNhTFRs81zW1yC4SAT4JrUK7ZQl9NH4V1MzYtiv+XCmhNEEPiJAQ31HUID8Mw33tPcNycaRaRg6HT5A1EBvJaV8c6hYvWFwkq2ioP2Fx60BRNADmQ0OcS3zs1llWddA9oLk12JwV+PPSui/XClWDc6f5605FM8NRc6AICaKU+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 20:17:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:17:10 +0000
Message-ID: <3445adc0-6258-15b4-2c9e-e48dc25ceb51@amd.com>
Date: Wed, 6 Sep 2023 16:17:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCHv3] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906153907.216159-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230906153907.216159-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdd8a47-3d0c-4d80-c5d4-08dbaf163fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1psNh1NtFH7GR9v+50RIRQpOXqIHBQm6bLmLTwbH/DLDMjKH3Ok5zfpAiri3huZv8Ys2qhbhihSr8qXusz/8Ox1khRKvV0kFmxau3S9lTH1QphuvwjEhq7UsAj526MtsndINIf4wYP+d1wWmRKtcwhMDU9dvWWtB6QHOcATC3HG7Enn7/k7h4cQWY2+T2Fpxld+AoR9SEdq1AtnoCqIosStL3XV8W0PBO9mKSkxrdeRzcG56kvcp40WydiHcM4FiUBCVLSzHgterAUEM+b/mb5s+23XNiJByNXeWs/6s67KtgsHpnDOru/k0uvhBZAE7P9FK41gOVZcWkYStTzuLw+Vx1K68Y8rQ08dTeODh1iNnvyxnmkXnTgicr5W4/JcloXePfkLDo4n5VlIhk0lbcWBbFY/PjfnqusMuW0A02HJHz+Q+pFXStnbMNlBAAZSHTkjec5Jig/2C1PaMImHZ8usIxs7LBl2bGVXwvdgOJW1SW3Q5mC9fh5HFOeQRBkESTfXES9hX82GN2Rk8TceM7m7bLh+qeyQJ0rRUsDYtrj+A4vyP2JNxvPXLqJ8uEIYYBd729nexzNjccEzaIeKWFhBH/VgMe98eFQ2WThtKWDR3Bg8zeo/z0NRn77Y/1xN/OTCQQ7GGUuHNWYjHNfiTZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199024)(186009)(1800799009)(41300700001)(5660300002)(44832011)(31696002)(86362001)(6666004)(478600001)(2906002)(8936002)(8676002)(66556008)(316002)(66476007)(66946007)(31686004)(26005)(53546011)(6486002)(6506007)(2616005)(38100700002)(6512007)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhWM2dnMnU2Y3BycDUydEpSVm83cmJsdHpuQ3RPc2NtVWkyQkIwVm1NZXVn?=
 =?utf-8?B?aXVjekljQzRkK3NRL0RVaWRhSFBKTjBxeDlTSEphVFBhOTMraDlNdzJhMzRt?=
 =?utf-8?B?WkVva3krTHVuWVBreHBVcWp4bUV5VUZCUndmcnpocUxrSEJmSU00VWhJc0xa?=
 =?utf-8?B?TkxJN3Bza3FrL1lqM0NxN0hJTDRtb1BkQWk3cG9yam5BNTBuajFrOThSbHpB?=
 =?utf-8?B?OGxnUDVpazR5WHJnd05VVjI4aVhhUTIvaFhPcHlwb0ZNZkVJL0ErSXhDUlBI?=
 =?utf-8?B?bmRzVExzUlpFWDhQMS9xRHl2aFZsTExDS3FESDBEL3VzbFRjZWJyeW1pY0hv?=
 =?utf-8?B?YzVzS0xRaFhnVUs1L0lkYXdxaFU0SmZJNFlaQWhsUkRRNkdiQXI4MjNueUls?=
 =?utf-8?B?THBCek8wYjgxaXUyRHkrU3BpKzF2NXlhRkJDQnh3ZlA0ODlBSVJFYVMraU9h?=
 =?utf-8?B?UzBUdzlha1FxRUoxUE5XQVg5TGo5SGZ2eWxleWhxK0w4aFRqb3V6OWFESk5x?=
 =?utf-8?B?WSsrMi95WUprdG5kRTQwTkxJSEJseFM3UmYzbFY1bUJRcHo1bjlHd1Rtckw4?=
 =?utf-8?B?S3MzVlQ4SzY2Y1ZBblFsc1FMWVVOUk1TRHlKUkRGaTVNZFZ6VW0wYXE3bUR4?=
 =?utf-8?B?a0RQUW8zZjczWEp1M0NGZ0ZLZ2tOQVdPSkZVZTV4bVkzV2VRZVNSVi9pQjdu?=
 =?utf-8?B?YzVoUWowY3B0Q0FUV0FrNTVXWnFVU0E2aWxpd3RxcGE2S1M4RmxmTVhSN3pt?=
 =?utf-8?B?cCs5aXlQRjhXNFZKc1V3dWhWaVRDTm9keVUza0JDK0c1bnFPVkRzNnNra2tT?=
 =?utf-8?B?VTBOUUt2My9JOEpVSTRZdlA4S09TeU94c2dMQzJiQUJqTXBLTnlucDJoeVVR?=
 =?utf-8?B?SW4wUXVMWWhVQmdhSzdFbGQrbG4rbFJwZkFrUjhoWnN1bFJoVFoweFpxUXhX?=
 =?utf-8?B?SnZRS3U1ZDlDa200MXFGK2hURStORXRkVWNaWHhTTlAzdjZNT1U3Yyt0a0JY?=
 =?utf-8?B?L0owYkp3QWl5Ky93TUtrWmxsb21MNE80SjUvRVFvU2dPOFhTN2U1UVEzUmhp?=
 =?utf-8?B?R1Y5dzlCR1Y4WlF2bys5cVlzYnkycnRRUDluZEIrYnhlMkhNa2F2dTVjeWFi?=
 =?utf-8?B?S0xreW1BWjlFWkZqcnpKZWlkYStLN2VvcDhKR2xhN1Jla1F6R1pDMXFBaVlB?=
 =?utf-8?B?cld2TWtXbEtUQnBicFdmek15aGRqQ01LT0ltV3RWaW9ydVBhVi9HSC9Lc2d5?=
 =?utf-8?B?VU5HQmFHWlFKQ2ZQeWovM0IvanlJZXB1UDFXYnpaYVlTdG1JbFdaNE0vdnhB?=
 =?utf-8?B?L2FKTzA2QXVxM0J2ZFg4N0RBN0hvQ1NqbTYyM3lOdVFqSG1DV2RUcXpQYUk5?=
 =?utf-8?B?cWNuOG5EU3dhU2dJZ1FMeUYvZDRrM3V1WUNGODZ3L1I1V2ZjSzkrQU96cVV4?=
 =?utf-8?B?bkJkTnR4N0R0aVp5ODZqeHNCelY3cm5wZG1oZGtxdTFJZ0lOaXpFb0lxbk5u?=
 =?utf-8?B?aXpZS1JrVm1HY1JuMnVEK0d6S012d1Zrc0JYWjBEUGZ4QlFpbTd6NWZVZmpV?=
 =?utf-8?B?VUpFQUxYNEJGWlFqYncva3BmV2dINUZ1QU9oRlhFVWx5Rk44Vm9OdWpZcld1?=
 =?utf-8?B?WGxBVHNOdm43K2k2eU1NN1lWUHJmSEo4Q0srNGxNVFgwSFdTKzJDYS9VeERK?=
 =?utf-8?B?SSt6SmRka2UvbEE1VFZUTHBTS1pkUWdTVmpFbkdoOExmb25CMkZsKzh6aFBv?=
 =?utf-8?B?U2kwaEcwQ0RuR2lXYjZYT2VLQk9mUjNPVnNSUGVoZlhEYUtDd0VDM1M0L2V5?=
 =?utf-8?B?L2didFpCTmlFSVNxdmRCV3ZuamVJZzNvbkRpT0tnMHlZSE8yTTNnc3ovZEhz?=
 =?utf-8?B?Qjk1cGo3dnd5TnJ0YXZRc2lmK2RFcnVKeUFldGlrMHJUL3Bwc2xZSzlBZ3Ri?=
 =?utf-8?B?MU5NR05XRUFPNDR0ZkFYTHpQcWxMS2F0cEluZUFqaUUyM1dINUQrWVU4alpH?=
 =?utf-8?B?ZXFrbTJJSmxnQmt2ZVNmNFVKbTBCZ05yWWw2VUFwVlNWWFQ4ZG52LzFUUDgy?=
 =?utf-8?B?M1BqSWlqdGRUVEJRM2NnS3JJS1N5M0ViWERtRG1iSzF6eEt5emZoS0dHRHJa?=
 =?utf-8?Q?Or9fdTtPYrQI6dAfBmzK0f2sP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdd8a47-3d0c-4d80-c5d4-08dbaf163fe2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:17:10.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtmJ0B7bQyXbHdu97w/TF6hN41ELyxR38NGUMO4zRm5vslbVi3DYYjEqHGsmcrudYuxSXOpwosVVndgVyNewEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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

On 2023-09-06 11:39, Mukul Joshi wrote:
> This patch fixes the following unaligned 64-bit doorbell
> warning seen when submitting packets on HIQ on GFX v9.4.3
> by making the HIQ doorbell 64-bit aligned.
> The warning is seen when GPU is loaded in any mode other
> than SPX mode.
>
> [  +0.000301] ------------[ cut here ]------------
> [  +0.000003] Unaligned 64-bit doorbell
> [  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80
> [  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80
> [  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
> [  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
> [  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
> [  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
> [  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
> [  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
> [  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
> [  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
> [  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
> [  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
> [  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
> [  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
> [  +0.000012]  ? do_pci_enable_device+0xdc/0x110
> [  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
> [  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]
>
> Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Update the logic to make it work with both 32 bit
>    64 bit doorbells.
> - Add the Fixed tag
> v2->v3:
> - Revert to the original change to align it with whats done in
>    amdgpu_doorbell_index_on_bar.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index c2e0b79dcc6d..7b38537c7c99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   		return NULL;
>   
>   	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
> +	inx *= 2;
>   
>   	pr_debug("Get kernel queue doorbell\n"
>   			"     doorbell offset   == 0x%08X\n"
> @@ -176,6 +177,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   	unsigned int inx;
>   
>   	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
> +	inx /= 2;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
>   	__clear_bit(inx, kfd->doorbell_bitmap);
