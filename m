Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BFAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 10:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FDC10E24D;
	Tue, 11 Jan 2022 10:50:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3EA10E24D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 10:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMzgamp/UCLFVv18p4VbHfjXrvnU1VjCcNxUw0StFEZxlElpVXJbq5VJnbbIkXVoT3OBXwY9vZBHXymjqCwlEbIeIqhbxyvHmSRgjj+2LSiqp74uBeYjoN+aZJh7YxeJEVteHSKvCpScSAcyWWPBcXn+zWzrX3PN0ryh4Y5abJkA6rMNJc0ovG7UFjre40CqiY3wjp5T/QNG68o1rndvrjwodHK51s4JA1P6Tzaf0zJWFc59F0s/2w11f2YNuO9ylJF3V1gLUzN+2BLABF1O1mFzv8A5WtLx8v65+d5e7HJ0c6TzgIVW11hWFLjndes6W4mtSLpejoCEw7zUSI31Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0JOcW5MHlhgM7vlar4XgT/iMNj3eBEiD2hkqkCFq7c=;
 b=RmwxfGTVzPwrd5HMw04uFlIjS/OWx8Ol95yviEFOd07cx/VG3Q8vi5MxNgSBc/Aa8ZitA/BHYCsYTW7bgGszwMqs56O73T2ICnY0ItBWEAT3cgv0XoX5JyBWagp28oSwiNY0GbJh0jKRLV6ES4pROruo9sCG0p31FX9p0RuPTrIgk/NuzOAjmUiCcJt2O/oK40HLmsB+ve5X3e/wKcAqxQTA91RyL2a+GULiXwVjlcb4dJWSGFi9PKAkDfk+kLqg0avbfVGrtOS3VA3pRmik2GJUFDEzR7AhDnIrP8GqX6yQiwkK6zPO3XFnLptRLBz3jPt4zo0y48zEt0BncK/y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0JOcW5MHlhgM7vlar4XgT/iMNj3eBEiD2hkqkCFq7c=;
 b=Kd6VTmwEGuD9Mjj6T97i03qXVhedSa7cYzd30IinUuoKZWgPlvoOLUW2b2u2EKIuYzij5GRQ+7nhh8vxN+xXOkw0wHzbuFOFCoAgZTmn26S5Xr4x/qMCR8yez7DaZ+e/KEiF5U90glM4PbdOZqRYyBGcOup0kIp8CvwaAwqawr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2490.namprd12.prod.outlook.com
 (2603:10b6:907:9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 10:50:23 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 10:50:23 +0000
Subject: Re: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, xinhui.pan@amd.com, kelly.zytaruk@amd.com,
 qiliang.huang@amd.com, bokun.zhang@amd.com
References: <20220111052137.28844-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ee42939-c156-f8a1-79ee-9892ca8d6f6c@amd.com>
Date: Tue, 11 Jan 2022 11:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220111052137.28844-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::16) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e017ad2-505b-4a17-9ec4-08d9d4f02b11
X-MS-TrafficTypeDiagnostic: MW2PR12MB2490:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB249023B22E3E4FDF01DF9DC883519@MW2PR12MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3RVIBjEcb3DcedUmES6gE3xW1K6bAoJkAzyNBOwB5P6g3gfD0yiGaOoimZeI+cz7YeLO+6AJ9q3/HDxE/f635xosK0+fTtNxHFt/PvX35dZWD1ye5H3kWf5dRh4Wv02iiSnjMHPkFj4Bbxb8+x5KmAa4YGjqKeATb++HBpZtbTGDHgis0vTgndUHh9U6vPkrQQrzXBsHo5QAhKPI2/5S6aBzM6AP0WySqdGKJNg3LX7M4rHWZqLZnczD5W5QuS7VC06mRhlIoFWnauym4osTDhufPuaoQXn3Shuu/7w5i560cKYq/k7/UYJ2jAnz4iAs/VsgKWId+9BhF4njm0MwyV3RHpnLLoRgyR30oif8CzgjhUGtS1BIDE9SAto6MJzi0GiMxSy1jbj8PoW7hGN2AiV7RX4MHma3IHxZgquvqt128PbvCUOFj/L1ww+TkmArMbOP6xvVGl4mKvyaguShoOlr3pYECfIfmygWIZyeakTxHhQnhzuECFhkxlr6eLEZmYRujGT6NGBKORStCykU7g+m7JtO+jgwmrrjFmVlHUz7fT7Ule4A+Msw3H+li2Ap6cjh5USexeCVA59+qBMUmZXVO5WqFl0xexjKjcxGYDs1zteRU6H1PwMIbFOOPdsnsLcKw7qQjbbo+is3LmqwESlLLYuHiGuyXqm61fyTjFtYAwRJ//P9qBHHs8ryoxbYFri0BafZu0suIg25n9J3jyMwTjzmh0U4BnLLAGPZcfnYRU8Vbrg7JDds4PkaGrM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(2906002)(86362001)(31696002)(2616005)(36756003)(186003)(66574015)(6636002)(6666004)(5660300002)(66556008)(26005)(6512007)(66476007)(316002)(6486002)(83380400001)(31686004)(8676002)(38100700002)(508600001)(6506007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlXRDRJdzc1MlVYejJ3cWtYTFZqOWk2akk1Wmt3Y0hoV0tWODdIdkozUk0z?=
 =?utf-8?B?QldaVk1XVmw3S0VGRU9tOEg4a3JlMzMwQjNXYm54bGtUYjZwaytXaHpxbWVM?=
 =?utf-8?B?R3cxMjZ6WUQrUExHZC9FUjVrU3hIWitKaUpScWJpbmFMQXV1YUt0V3Uvb2RJ?=
 =?utf-8?B?bkZpRGh6V05WTmdxMjh6Z1BrS3UwQzFETkhRWVJycGR4K2o5bFZZWmZYUXJP?=
 =?utf-8?B?R0I0cWNXSHNYb3ZLTjBBaVhRdWtrUG0xeHBQSUhhNDljK3MrTE5DWGpkMm81?=
 =?utf-8?B?akM1ZytUaEVnaTVQU29qb09HY21yUkhsaFlFU0ZyOXgwWk9lQlg3ckZpd2pt?=
 =?utf-8?B?MEJGKzhqSzNQRktyTzZtQk5IRFltUFhmekdZRnFGMmczM3JmZWJCWWxuV2U4?=
 =?utf-8?B?OEEvMkxxN29OSlJUdURLeXJnZDVISjZxSlBPY2FXNG5aS0ZPQjVzNEhTTXo0?=
 =?utf-8?B?RlJzVGd6bXZsd1RXVG9KQTFhNzRSVnJxZG5tSDQ2SHRTQ2MwdDVxSGpxZWJ3?=
 =?utf-8?B?dDlnSmRORk9vVmVzTmxBRXEzZFR3TTYwcm5DMWhCM0twUW5ET1dYd3BJeWtP?=
 =?utf-8?B?blRUbkpNZ1A2M0NITE1sbk9RQ0pyTkRqWEdWQ05WRS9LL09FLzZtRHZudEpL?=
 =?utf-8?B?M2YrNlNqNjRzSDM5QUl0YjRabktkS0pxd0J2NzRjcGpKQUJlc1Z6TVR5d3ow?=
 =?utf-8?B?Y3orQWJmMmxGNjh4dEJLR1hlc2YzMjlkVjFzUUpUNEVOdXF2ekZjM21KQXNk?=
 =?utf-8?B?UVQzMDNqMjBVUmY2U0QyNG9WeWJCdnRsRWp2Z0FBZVc2aytpMDhlY0J0dmJp?=
 =?utf-8?B?dFZHNnB1N1RwYVpoTTczQTM4ckwrRkg4cEVKRW5CTkNQbU1UUDUzQ0FTZEtk?=
 =?utf-8?B?YWRjMGRLdEpHRWJ0N0hnMEtsVjBJZ2dzRWZVUGpXZmRvQ09lZU1McnAwVi8y?=
 =?utf-8?B?SndYSGZNelhETVowQUVic1owNDJYQi9laVQ0aUptbE9pdTVvRlAxSGtEdXNN?=
 =?utf-8?B?RENpMDF2em5kQ0wvV0RZNFFocUVyUk0zdkV0U29ZcktqRjZ2TWtBcCt4Z3Zp?=
 =?utf-8?B?RnBSSFZVaEJ0bmh3N0JYaWlYaVZyb1Z4V1BmU21WVGsvNTY3c1hRK2h1TzU0?=
 =?utf-8?B?aUhVNEY2RkFFcnpaY0ZqeWpJcUF4YkVIa201MDZHSjdxa1dRZzAycDdRSmlh?=
 =?utf-8?B?SXowWXBaSWk2TWFQUGkzQnpNOHk1czdkdmlBSzE1MjdpMklTdGZSUTZ6WDV1?=
 =?utf-8?B?cE1DREZOT2FqRTh1c2QrVEVrVlNOSnRZc3BZTDhWcSswUHYwdjA2eWZVdnpT?=
 =?utf-8?B?UXpwcUxpdEFLVjZDRHhhUXFJTTRJaEJRMndGbVdUUlFxOGpLRDl2SHIzQUUz?=
 =?utf-8?B?L251YjNNQU5XY0JtaHNRdDh4bG0reGxqekJYL3gxZmlhK2w5RmpYRzJySnox?=
 =?utf-8?B?U2FIbE5LeERQL1k5WnlFS05CU1dWb1hEZ2VmTnlnNTZPZU5YaVU1RkI3NWpa?=
 =?utf-8?B?anhjMjFFRm5YVk53RThTTWNvMUpWVEZtU2hjZzVPcFVLNzFsSGdPRXdLdHdm?=
 =?utf-8?B?c1dGRnB1eXZxdWF3Nm5hZDl6M0lBd1F6Zk9MaHAxa0txVUFOelZodndHdDMv?=
 =?utf-8?B?REhmdGFkekxuS1VmWkdqWGJ4V0I3VVNmSnA0MEFmRys5TEtSbGw0ZUgyNm8v?=
 =?utf-8?B?Tkc1dVp4YWdaYjJzY2Q5L1MxeWFxUENCMWY3L0RXMDB2T0pXM29yN21NSUJZ?=
 =?utf-8?B?MDN5Rm05QnpQckQ2aExXbmZRSi9lWUFOU0YzRG8xQmRwelpDbkpzTng1TDkz?=
 =?utf-8?B?UnUxT3pBVW1tQVcxbkxFZ25Qbi9PVHZQcExJTDhja0RhTmMzdXQ3Wi9tdzg2?=
 =?utf-8?B?USt4ZDJtMjhiOXIzVjdGL0hvK3I2ZC9qU0o0Q1JETUNjQUdRa1Y3UkZwa3h6?=
 =?utf-8?B?OTU5NWRVQUM5NCt5TEtjRVhSNXdnWG1xeVgxUTVtd2JvQTBUYmNNZ3dqT3k0?=
 =?utf-8?B?WGdUK0UrbTQ2eGk4YkRGa242Z3FscW94M1RIMTdibDByV0Rpb2pOcUgxSE13?=
 =?utf-8?B?aGhFMFErYWd4YVJVQ0JjYjNMd2lyM2JhUlF5ZlRBMjc4dzY3Q21UajhqSDZO?=
 =?utf-8?Q?CHjI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e017ad2-505b-4a17-9ec4-08d9d4f02b11
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 10:50:23.2262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPQp/yS7XOpSztmYJwcdFcPVJgHDt8WEGbN97vIkmtE5N0Alb4DrXfXqszJYQvUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
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



Am 11.01.22 um 06:21 schrieb Guchun Chen:
> This is observed in SRIOV case with virtual KMS as display.
>
> _raw_spin_lock_irqsave+0x37/0x40
> drm_handle_vblank+0x69/0x350 [drm]
> ? try_to_wake_up+0x432/0x5c0
> ? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
> drm_crtc_handle_vblank+0x17/0x20 [drm]
> amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
> __hrtimer_run_queues+0xfb/0x230
> hrtimer_interrupt+0x109/0x220
> __sysvec_apic_timer_interrupt+0x64/0xe0
> asm_call_irq_on_stack+0x12/0x20
>
> Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 2dcc68e04e84..d99c8779b51e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
>   static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>   					  struct drm_atomic_state *state)
>   {
> +	unsigned long flags;
>   	if (crtc->state->event) {

Please add an empty line between decleration and code, apart from that 
feel free to add an Acked-by: Christian König <christian.koenig@amd.com> 
to the patch as well.

Regards,
Christian.

> -		spin_lock(&crtc->dev->event_lock);
> +		spin_lock_irqsave(&crtc->dev->event_lock, flags);
>   
>   		if (drm_crtc_vblank_get(crtc) != 0)
>   			drm_crtc_send_vblank_event(crtc, crtc->state->event);
>   		else
>   			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
>   
> -		spin_unlock(&crtc->dev->event_lock);
> +		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>   
>   		crtc->state->event = NULL;
>   	}

