Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82244C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFFC10E4BD;
	Wed, 31 May 2023 13:06:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E7610E4BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFuywXZQWJ8G0dFVMxvN4sQNKnI1LnomqRTJnY6BNg0CR3PxXRQlzE58s47vlapoJ/XxQVyHcuenJ2pAoV82ZtRUTH64tuJBNvquLEjFxa1EY/oGAVJ4w7h+dwKqp2q9YrFMwOHR9BuT3Zbg2VQLFSLXVeuwqUe0H1uHmB3RhahNcMY8D9GMb6GK4jsCjAOSGHay9/zOAx7mhHQrTzUC/XJCp/Z3YQ7Fqi106zxmJ6LqprrU29pP+1bFmMFEmD9Kj9tVmb1M8UzxP2p1PsNFzRcIcl3bQofK4Qa5qZjqBQEj3TKOLhovU1Q3pkrwveZ/unlUcVPOZtqJgfBu+N1kwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FyD1qxd01tbJbDNrYsIcI2bFcA4Mnrc1UmEC8eQHaI=;
 b=fHjwWB0117ozG9Gsovwy8QX0X+Jm1HlWsCE1rDkaZDwadn0yC9+tZn6w/GelvDr5pcmVLLo1+1PbU8+vwTO27pdgmqGjVlpFvAl4sfiZc7UG56te1VlCIVfPqElg/KY1xLs2cgETI3ntMwW1ZfInz2/jKjO89QqU572VzYBWRxxtVP1Wd+0VD5AzLdbq0Bjk5TxnenKl70fRH0we1VgZU/z7xVSY2ZmC6C6PQle3ndchtLyhZWQcSzb2mu5iqVvflMq6bSoYVBc/U0IGyltwTfXF7vYzfcP/jV2YRcMwabk/eLRsO8jhD71ocz9gLrIWkF0Z8hoctNtVHySsAQlXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FyD1qxd01tbJbDNrYsIcI2bFcA4Mnrc1UmEC8eQHaI=;
 b=adAsXleX+ToScv5l++zYwuAD8NOshfMcgPL/coe7CXoTfO2BWzKN14kl4GT/PzZiZB1BJ/Mj0/R211+LefKJ9msID302VfGtH31dChJ9vGik6yqfdyDToLZX1woc3Fidw0WpjLVVx6bbqIx0NbS6R6QEq2pD2mZcK2F5k7160sU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 13:06:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 13:06:54 +0000
Message-ID: <17ecbd4b-1637-4a43-7240-0c08d0833600@amd.com>
Date: Wed, 31 May 2023 15:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Content-Language: en-US
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Frank.Min@amd.com, "Liu, Leo" <Leo.Liu@amd.com>
References: <20230531093405.519280-1-bob.zhou@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230531093405.519280-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe16b86-839d-4368-24e2-08db61d7e7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SigQpQA++OfllmCXW40Y2X22A6QPwrZhZ2r5/HM9MaabhJs0zpGJiLOuR4Gb3qYO/tzG4sEv6iZZMA0NYVdgn9HJv5XUzWBT18fl57vQAspOIlzS3zk46+HOVMU78lBynFFpQjFgyiZ6xOgrpKG6VVZWz3mSpHUDk2OxzSvP8cwp+zEjrYqtNAVTmbAr0dP0K8VRuf5TqZ37AKjxmtoFkWETPxjsetDPN6kUYb0jYSwl/7UMHZmHnYiK7B9LAS8nHnSj3PoGPcaW59FJ/JbjoYFVqbuZKDgsTANq6x2fx3qKm+VDuk2B0YVmyXG6QsM56Q4vnE8Ke7RvF5xRArzCad1JODwo3CfqysOx9Ilzkj24uyb7AufU3/VIorgOdedYxg70pB54lQ7zMARXWZ/ohW61Ewln6DXletmUkn+5h0uWJAahL4Cek9nJ/Wwx5rfToh8aB+aHZyPUF56NUuUgQ1tr5eSeY2HrGwDkDPI1aCMEmvb2gsstwlAtCgtuh7jWPqfEEw5Cu41eJFO0X4OLUofVDzTnZaKwZMc6SWTA7yuv1Y0PIuhgDOAIgtg6Dz1TLAWIABmGZp4UZPmiztjug25gFk9nZEI4efB6Q7rRpT3K8au3lKf0w0843iyQibHlhK7jQtDLEfDVoIPoDeV7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(478600001)(2906002)(186003)(31686004)(6506007)(6512007)(5660300002)(8676002)(8936002)(110136005)(38100700002)(2616005)(83380400001)(31696002)(6486002)(86362001)(41300700001)(316002)(36756003)(6666004)(4326008)(66476007)(66556008)(66946007)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJwU2lRdXBZRXgvZkZsUHJYek9RL3J5YWFWUVVwQlhqNVFoNUFEMjlYQzRq?=
 =?utf-8?B?SkdoS2JzdzZlTUk5alR5REJSSTBFWm5LOWxsbkZIQ1dmWDA5c3VQL0E1L2Vu?=
 =?utf-8?B?Sm1aaEhVT2E4aXJyYW9acENRTExQZ2M4Y29PaHR1aGtSSHQxQ214MWNLRU45?=
 =?utf-8?B?SmNld29JM3lZdmwxTGdMZHBSclJvdnJtTE04aFIrSkFnSk5rZDY4aUMvQVlq?=
 =?utf-8?B?SUZHZW04VlZiTXdhOHBvcEhqbC96K2o5VVlIcllZV3gxajhOY1YySTJRQXBl?=
 =?utf-8?B?NXNXaXJzUXNRYWVrMVNaMU1sMzBudnZJZ3BONWgrYmIzWkdLQ0UrNU9xR3M3?=
 =?utf-8?B?aTE4eFdtZmdPenVrSFkvejc5MXN3dWljaUx1Yk1VNVUwODRxVGFTc3NBb3Z2?=
 =?utf-8?B?RllkY1lJeXhYaVRwYnc2MW1Ra2s4QURQS3lQcEtsd2pNcUNmQTZwSjBNY25E?=
 =?utf-8?B?MlgrNmkrSWN1eVFLVGVmMk04eFlrMTh1K3BnT2ZQc29EWGZNUW10bzVtUlkw?=
 =?utf-8?B?cDA5Vk1ya3Q4dmV0VW5WY2hGblBlN1gyK2U0akNIY21yNmdZMVVpajZWRjFV?=
 =?utf-8?B?a04wOW5lUmNqVlBKRk1Nd01vbFhtYW5uTWlnR21Zck1TMi8yM0hWVU5WVmpC?=
 =?utf-8?B?UWpBZHgyUEg4U1k0R05PM2hwaU5sT2x0M2lpeDdhU3drM3NoQStwakRwbkND?=
 =?utf-8?B?QThXalA4ZTJkcFZld2E4WEFkZlhxaUUwckFBR081RUJsNTNCSlJBUHo2L3ZT?=
 =?utf-8?B?eVI1djRUeEdHQ2JDakozdE5jV01YV2dYTVp2NVZSeU9Tc0Y5VDNrZEk4dTNK?=
 =?utf-8?B?YXhtcitaeDhqeXdUdmlOcG9VNzNmb1FxZnh4NnNWQkdrdmdjN2laOVZ4Qk95?=
 =?utf-8?B?UG1NRXRVYUR5alJrcm1OdElkbTBmRHlZWHBnaThHR0Z2ZnFJa3hBc0lhRVY5?=
 =?utf-8?B?a0tZN0pIZ0tiRmExZTBxS1hFVTZ0NnRpeWFoS1pGbnpsNWFRTW5HU0dBVU8z?=
 =?utf-8?B?L04rcGFpUEdQc1FGQ1lObmNvbVE4MnJELys4bHN0WGROSTU1c0I0eHNJOWpL?=
 =?utf-8?B?V1ZseUp4bm9JRFdWMnMraGlqUFpKeGxhb09ZcUErVTZabnRvS3Q4SjlvQndx?=
 =?utf-8?B?SDA1SXAwV2Z5MWNESlhFWGNLeEQ4UWZHMmp1bFFvZTlOS3hKYm5UekRJNFVS?=
 =?utf-8?B?c0llYWsvWWxiaWJjSzZNejVMWmpEOXl0ZjNKZS8wVXlENVVSeFBhN1lVbFYr?=
 =?utf-8?B?WVExODZWNHpWL05TazAvQU1ldTg1VVJUVVI3VlllVzBIY3JZbzFIWXpZNlVO?=
 =?utf-8?B?dmFVZzRzSHZuUDl4RjdFNTZTNXUwcG1rK3dYVloxZFJ2eUEyZFRuSTNaNkd2?=
 =?utf-8?B?clBpVzJ2OTJSczhxdFBUMWNGRDlaaTRGUDlhUFVzRHBqRzhtMXRRQXJBaTlI?=
 =?utf-8?B?TWd6RHZVYm9XNktLZTBReURwRW14M0F1a2NTSDJiUTRGYy9LQ3FKUUVBSTZw?=
 =?utf-8?B?eDQzc1lYdGtTYjluUElxL0hGdytWY0xXb0YrTUxXL1Nmdm95TkdVdmZ1WjR3?=
 =?utf-8?B?RmViZWpaODBrdldoZjRJT2J3R1lNdXl4SGtzbHk1anVDajlHemEya01vLzNM?=
 =?utf-8?B?MGdUcFFzSFVWcEFVTHhCWHNRb2hoK2Z0VWVnY0hBR1lDYjBBcXZ6Z1F6ZWVO?=
 =?utf-8?B?NW9yZXBPNXEzWVM0TWdNeERqK25FdXBnWERxRHI5V1NTdnlmZGtKVnpyUnI1?=
 =?utf-8?B?eGF3aFZXV3JuRGp0QjNZcVh1cTZHdnQ2ZkQ5U0VRa1NRZzhQc2UrSnRRRUdH?=
 =?utf-8?B?M0JBS3ladFJWT1RaclN6QTJ3Nk5KanJBSEwvMFRnVnlQaCtrOTRXcWFCb1Z6?=
 =?utf-8?B?Y0dpdFo0M3F3elFqbE4zNzU1OUZScGJaemdzRXBrTWNFMVpjVTlrSkgvSG1h?=
 =?utf-8?B?TEFIcmVFZGh2RU53YTc2cVZVYk1qMGQwNmFFby84Yng5RUhpSU9EbDczWGZl?=
 =?utf-8?B?L1R3Qnc0eHBQR0dkWjNiQ0tVM2JUY0hJSXgvQW1GSzFuc2F0YXQ3UUR5YjhS?=
 =?utf-8?B?aWdJMjBUMVh2dXNlemk1eFZOSmJTWERabkV5SG1GQU85N3dwa01rd3BXNngr?=
 =?utf-8?B?bFN0SFdwM2dRcEkxbzhEREUyb2swSW9RK2lNL05JQ0ZVbVF4eEFJTmQyTTF5?=
 =?utf-8?Q?4wE1R6mtUIkc8EqbbNij6BKXbFG8b6Qf9Z7PV+megqwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe16b86-839d-4368-24e2-08db61d7e7f6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:06:54.4492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKFZTJ83VHGI5uRH90v6d9KbVMVHZE3VsESN2qO5rZR1gbjwf+sPb35lbbaNgf7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 31.05.23 um 11:34 schrieb Bob Zhou:
> uvd ring in uvd_v7_0_sw_init only initializes ring in bare metal case,
> so when executing amdgpu_uvd_resume to restore fence seq in SRIOV,
> a null pointer dereference will occur. This patch correct this.

Mhm, taking a higher level look at this why isn't the ring initialized 
when the VCPU BO is allocated?

Adding Leo as well since that looks more like a design issue to me.

Regards,
Christian.

>
> Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -ECANCELED")
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Oops: 0000 [#1] PREEMPT SMP PTI
> RIP: 0010:amdgpu_fence_driver_set_error+0x3f/0xc0 [amdgpu]
> Call Trace:
>   <TASK>
>   amdgpu_fence_driver_force_completion+0x18/0x50 [amdgpu]
>   amdgpu_uvd_resume+0x1b2/0x380 [amdgpu]
>   ? amdgpu_ring_init+0x73c/0x820 [amdgpu]
>   uvd_v7_0_sw_init+0x358/0x450 [amdgpu]
>   amdgpu_device_init.cold+0x198c/0x1fdf [amdgpu]
>   ? pci_bus_read_config_byte+0x40/0x80
>   ? pci_read_config_byte+0x27/0x50
>   amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
>   amdgpu_pci_probe+0x186/0x3c0 [amdgpu]
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index b7441654e6fa..70e7e9585d3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -506,7 +506,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   			}
>   			memset_io(ptr, 0, size);
>   			/* to restore uvd fence seq */
> -			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
> +			if (adev->uvd.inst[i].ring.fence_drv.irq_src)
> +				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
>   		}
>   	}
>   	return 0;

