Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA4BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 07:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D3310E819;
	Wed, 15 Jun 2022 07:29:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA9910E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSV1XojW4Wh2Q7B9p9mvXzH6A+5dXPauH+i7jEd259oqwlVU03XJ2IjZUpKC6Mii9vuB8WMX9jgfTQAMCnsPKbEUvB011YPxQouC6wS2HT/eiI55hrFPEpS3pJcPwF048AlKcRNwoIHNBEzSzqJMXzcaNy034gl27IsALMURr6qKo3JisqfUPpfco71kXqhw3Sy+QFpZCg20S4eN1JcmuLmYEITCRpT8sEgt4ILVD8RpJXsS7eH/t5ecnbGlk6EPhaA79FyZRkfiShVpFcnw8hPAEKOFRRsXWs2XS4ZlhlzB7ErRwxwXSwwwJ74KiRwcPa/pJ+JfbFpJNT2kwxJwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJQ+w9sAnRsGCi8xrMNWC5Pe5OvCtpY8/jQ+IEb7klA=;
 b=QwshmBvqVnwDBwB8+noGuENbvgEM8uAqL9JhLKqEADvpAm8FuemyA6EEagqvKdDfndWvvznDnIZwV0rTHgE6G2OSTDWrd9h8VzQbyGEjR0aO/fi3uP/9md16/wVXwM2XW8YPRjtjx7rI82TrwRxJj5VSntyD/uwBkdOQ5xgh6hbZS6BTOMa/BxVhzSjbeuvR38PwSwY5Y5gcSGkpfO31ox2ePXDBBEwmS8fDx3tbNZKfkeQ7W0TDhijo2HOb+7ze5XdBfrFPHwWBDy3WQCde+RIPse1m2vqhJuMQw2A42zd/AWpd/FdDFI3pLUDLlPHnMZo+KhZwO6JX8g9vzle0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJQ+w9sAnRsGCi8xrMNWC5Pe5OvCtpY8/jQ+IEb7klA=;
 b=FXqr8YN/r9hMf+oCX0nD8bhpYoIROVC1KaTn59pTm7nr714xSmUCed+kjqQ5jyrH8sztPYQ8rWw+DWAcC2I+rAExytg6Om0M3psuXJS+Yjtm0WvO1VjG61hmKXL3fMmf09YcNVGlyN6+RE2j9xTHqe2L+4ZaeExrIa+zyr+SGOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 07:28:56 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 07:28:55 +0000
Message-ID: <453d57bf-e1b1-9dcb-9022-21444d2c64a8@amd.com>
Date: Wed, 15 Jun 2022 09:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220613152001.3045911-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42aafa4-517c-4942-60f8-08da4ea0b409
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB551458E28E86B4239AB3B79083AD9@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9Mw0HB+AHC+hKVAyvSoEFPfpDR7Riu1XPrLzXc5PLD+EBihv+s7dTF80T5jL4y6ejDCnpzZjDaQGUsUhoY8xxMWwAXCXDt5AvdPJABhDWTYtfjwGEpDvRBfjFDrrtw314Q1tYBl8GcTZHZXp5wLX2AeRjHNZ14oZoZ4NZBRcPYh/1w6rk6c9+neDgSiAExTWTp6fERAp+nAihUy2sttmS/LNCaM98a0wjbN7m/ET70TiqfEoPUfzvMkdaJlW6BWYs64J5okUzKsQs7/6WpLxgW2VH6pfYtxwiRc7OEUx0wTN2uju4cTrsgog/rfQ6Sf3ALarXNfLjLoUlp8p2/js/JbnXQeJF5xeLlq9c4C/SEW4N00iN04BOGySPNE9pKkVXG3iJb99avVB629qZn8ZEZJqO/hx5uodSh3EHPFq2SVb8Kwumyn5IiLL9KwJS739ZP9jeLrJh0DrTlnX3tXyQp0up10g/EgRVEu+4scf46Zjpom8sU4KzUd2ZLCF723DJ37WTXauxzH53hes0i4xfWH66R5NNc7e3mtUQHkK3ERRuwNFRoKxbED6RjnnUXY/kHH+iCDi+1p2RE/I9Xmde73eZKewweIxADjLCh49NQjGiN8E/an1KW3A8+YngVEgAagqdZ3aOqFI5B195itV2axbk9cNPf0pNW1411LrKWPzvsMf84kyIBm86y6FrBNuBN2gdx2s1J7eeU6QWv8fIe0SyyUkxIUXDAfuHnWiZ7yxTLmWPrWGU3RGAeEr7c/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6666004)(31696002)(86362001)(38100700002)(31686004)(508600001)(5660300002)(2616005)(6486002)(8936002)(4326008)(66946007)(66476007)(8676002)(316002)(66556008)(6512007)(36756003)(83380400001)(2906002)(6506007)(26005)(30864003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNlTGpHSEc3Z0ZTMWl0YThFcTZKcUxuYm5jM2RDOGUzeDhRWTY0ckhyVzJD?=
 =?utf-8?B?clcwa09pQ09NRTBJWC9kYllGK1RObDNxSHF6VDdzWkh2ZWlSWEpxTi9DcjNG?=
 =?utf-8?B?aVhjU2tQRDkreVJFV0h1S1BqcG03NERTbnVkckgyRmRFU2hBYjhIaFlJUC9S?=
 =?utf-8?B?SUtPYnhQUTJNMXRKTHM3UUp5TEpSaWIyWUpwdCthWGVLZ1lBL3JsanhrejVz?=
 =?utf-8?B?UjhYOWF0cG1CcHdpUnJXc09YbHRSN2VXWXZMVUNCNUc3QXlLTm5haGh0Yytj?=
 =?utf-8?B?WElJSGFYNUs3ZVdNU3owU1VJVDB3UFhMQ3hQY0RJVi9acEo3Rm1yeVRwZW9O?=
 =?utf-8?B?R0ZMM2lDTXpWRUxWZk9UK2o5SU9rMlBaNkd0Siszemo2aG95aHg1R3l1cEdq?=
 =?utf-8?B?dTdWOTZQM1hNUlhTdW1KZ05kdWhiRkRFNm5rTDVUM3FsSm1ENGNYNFR6MkNX?=
 =?utf-8?B?bUhLenlVZ2dScm5tMHN3REN2aXBMaTVnd1Rhb1UwN1BmaTVSNmNCNUVkbTFE?=
 =?utf-8?B?QVI2d2tlQ0t6SVVubElZRzJEdTJGVitzSzIxT1ZPd00zT1VBSGF3dmdSVzVO?=
 =?utf-8?B?U08yTG5VOUxEQ3J4NUxKa3YwYWJIbFZURk1HaGQ4QXg1WXB1Z0lMT1lhdjln?=
 =?utf-8?B?cjAza3NHUDI3UTRwNHZSSW45RkN1Q1k5aHFJQlkwdElDNDd1bVJXVk1qaWZq?=
 =?utf-8?B?SmRSemoyV2FLMWpUOFVDVG9RK0NhaEU1WW5lcnExb2RhSkwzVEltMERiZFVQ?=
 =?utf-8?B?QjNXYnRyZFJZMW1UVGx1R1NtZTBabXJmTGJGcWIyYVQ0aWlzSVNBQ2xTZ0l4?=
 =?utf-8?B?TmExUS9oWm9WSlltUFZuNGU0ZlpyRnlxK0Z5blRzcDZmb1JETDRKQlhYS0ha?=
 =?utf-8?B?RFRObTRKWnYzVnJUVUxVbEVRckZnUi9hZ0t4Qi9UWFR6THFkYkY0RDdaVWNy?=
 =?utf-8?B?Mkp2RU5rSkNJNWxuenNJbWlsTnltblQ1VzUyQzZaQ0VibTl4bllXamF1YmZP?=
 =?utf-8?B?bm5hZGJuWFhqWkhVekRxMEFPeTZGblRtcGlOckx3dHcrREF3OXMxNW83allH?=
 =?utf-8?B?WmQzVVRqamtqVGVuQ05CQXMzQThLakVvTkgvUjA4Q0ZMUzdZNkZMM1dDUTdh?=
 =?utf-8?B?K3FoSmo2MDRSancxbWFlMjFLSTREZkFlWStiVU9NZVNJanlwN2F2ZWFFMzkv?=
 =?utf-8?B?QkRIMVJWSXlnYXpQcnNoblRzNTB1MjlyTmxzbTZudU54bE8xQmxicnIvWXNi?=
 =?utf-8?B?R1BPQlhxc29vTVNnQldYRGp2RkE1Z2RGay9wUkh5cWNLYUdQeEVSKzRiWnNL?=
 =?utf-8?B?eU5Xbklid0hyanBad25EYW95VUNRTGtTSG1GQ3BXOFpjaEY2OFIyZ3BlQ1A4?=
 =?utf-8?B?Y3pSUlltd3E0WlVjSUMyMXhqaHZ5OWh2WVd6R0taK081VkZVRUlud09LdVdi?=
 =?utf-8?B?a2Z4VDZoUnoyOWx4eXFZN1l5d0l2RTRRb2syc1FNenRBZFZvczF2OGZraTIx?=
 =?utf-8?B?VjQzSE95ejd0ZzB0dnZmK2FnSjdFNHZzOTBRazZQRFhIb2tldndiVnYwMnBR?=
 =?utf-8?B?SktxY054TGNXM1V2RWFZR3lKdHRwS2xKRit2cTYyTWNVbUJ4S25DYWs0Sk0y?=
 =?utf-8?B?ckNPM051MTRwMUduQ0tzK0xqYzd1UFh5RlM3SjZ1VTNuNmVNT2J5WTRzRW5m?=
 =?utf-8?B?a2ovaDhucmJNQmNDc2RPNHZkOHhzb1FtMldXaGEyeCtZaHVzcVR1SEl0aWpF?=
 =?utf-8?B?MVZYZWFZVy9TYXZBQ1N6N1ZnSFVvMVJBdUNJWW05ZUNqMEt4SUtoWEhJQk5r?=
 =?utf-8?B?YzVyRzR4YVVhOVFYL0xzcm43Z2hOUUZWdTFkR1I1SVkwSGloTGtJWXZ0eGN5?=
 =?utf-8?B?ckZqcE00aEU4UUFhYTVyMjRINHhtbi8rVGRaYTNla0NkRU91bDF1dGxnMFBm?=
 =?utf-8?B?QkxTQzRqdUtBOGl5MVNESUNUV3d1ZmdvVUVZNjJPbTJKUml4dkpTck5VYlB6?=
 =?utf-8?B?dWRvdy9xN05IdmRabzg3Y0dmRENxSUVYSkJPeTJXTEVqMUJ3N2NEMTQyeUpC?=
 =?utf-8?B?VWl6OFFDd21ESzIwK1pNZUNvSnpwMHppWGp0WFlmMjkzUjVsN2ZSYW9pc3NU?=
 =?utf-8?B?QnpMTjdOWS9LV3V0cEhqUzMrcFpZNzR6R0xjaGJtckg5cHU5d2svTkRvNzQz?=
 =?utf-8?B?aVE5dldzVEExSGlrQ2RYbm01RmdYTllBWkxNTGNqWFZSVEVMT1JkS3pTdVlQ?=
 =?utf-8?B?YWNyYnlubFpvdnJ1RW0xbysrMXhLREY0Zmx5YnNzd1VKMXNkTlJJWXJzanFh?=
 =?utf-8?B?ZGJHZEFEbFZNWG0vUlpTVzlqaG9uUUJ2c3BzVXdidTJOSlRGQmhlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42aafa4-517c-4942-60f8-08da4ea0b409
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 07:28:55.1093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Ho2gc+8x8vin3TBOvoFX4hx+GKQryX5s+AqRwI6wL836p4ERAsZMMzgnZ87faF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 13.06.22 um 17:20 schrieb Graham Sider:
> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> GART for usermode queues in order to support oversubscription. In the
> case that work is submitted to an unmapped queue, MES must have a GART
> wptr address to determine whether the queue should be mapped.
>
> This change is accompanied with changes in MES and is applicable for
> MES_VERSION >= 3.
>
> v2:
> - Update MES_VERSION check from 2 to 3.
> v3:
> - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
> - Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
> - Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
> - Cleanup/fix create_queue wptr_bo error handling
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 49 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 37 +++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 17 +++++--
>   7 files changed, 110 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 429b16ba10bf..dba26d1e3be9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem, void **kptr, uint64_t *size);
>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index efab923056f4..888d08128a94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   	return ret;
>   }
>   
> +/**
> + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
> + * @adev: Device to which allocated BO belongs
> + * @bo: Buffer object to be mapped
> + *
> + * Before return, bo reference count is incremented. To release the reference and unpin/
> + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
> + */
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		pr_err("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		pr_err("Failed to pin bo. ret %d\n", ret);
> +		goto err_pin_bo_failed;
> +	}


Oh! Is that something we do for every MQD? When yes that here is pretty 
much a NAK.

We can't do this or create a trivial deny of service attack against the 
kernel driver.

Regards,
Christian.

> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_amdkfd_remove_eviction_fence(
> +		bo, bo->kfd_bo->process_info->eviction_fence);
> +	list_del_init(&bo->kfd_bo->validate_list.head);
> +
> +	amdgpu_bo_unreserve(bo);
> +
> +	bo = amdgpu_bo_ref(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +	return ret;
> +}
> +
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem, void **kptr, uint64_t *size)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e9766e165c38..1789ed8b79f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
>   	uint32_t doorbell_offset_in_process = 0;
> +	struct amdgpu_bo *wptr_bo = NULL;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> +	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> +	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> +	 */
> +	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 3) {
> +		struct amdgpu_bo_va_mapping *wptr_mapping;
> +		struct amdgpu_vm *wptr_vm;
> +
> +		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> +		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +		if (err)
> +			goto err_wptr_map_gart;
> +
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
> +				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
> +		amdgpu_bo_unreserve(wptr_vm->root.bo);
> +		if (!wptr_mapping) {
> +			pr_err("Failed to lookup wptr bo\n");
> +			err = -EINVAL;
> +			goto err_wptr_map_gart;
> +		}
> +
> +		wptr_bo = wptr_mapping->bo_va->base.bo;
> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
> +		if (err) {
> +			pr_err("Failed to map wptr bo to GART\n");
> +			goto err_wptr_map_gart;
> +		}
> +	}
> +
>   	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
> -			&doorbell_offset_in_process);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
>   
> @@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_create_queue:
> +	if (wptr_bo)
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
> +err_wptr_map_gart:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b39d89c52887..d8de2fbdfc7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,6 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mes_add_queue_input queue_input;
>   	int r, queue_type;
> +	uint64_t wptr_addr_off;
>   
>   	if (dqm->is_hws_hang)
>   		return -EIO;
> @@ -227,7 +228,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>   	queue_input.mqd_addr = q->gart_mqd_addr;
> -	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
> +	if (q->wptr_bo) {
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +	} else
> +		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index f1654b4da856..35e74bdd81da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
>   	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
>   	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
>   	m->sdmax_rlcx_doorbell_offset =
>   		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a5d3963537d7..dcddee0d6f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -639,6 +639,8 @@ struct queue {
>   	void *gang_ctx_bo;
>   	uint64_t gang_ctx_gpu_addr;
>   	void *gang_ctx_cpu_ptr;
> +
> +	struct amdgpu_bo *wptr_bo;
>   };
>   
>   enum KFD_MQD_TYPE {
> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index f99e09dc43ea..3a17c1ebc527 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_dev *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, unsigned int qid)
> +				struct file *f, struct amdgpu_bo *wptr_bo,
> +				unsigned int qid)
>   {
>   	int retval;
>   
> @@ -221,6 +222,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   			goto cleanup;
>   		}
>   		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> +		(*q)->wptr_bo = wptr_bo;
>   	}
>   
>   	pr_debug("PQM After init queue");
> @@ -237,6 +239,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> @@ -299,7 +302,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -320,7 +323,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -457,9 +460,13 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   			pdd->qpd.num_gws = 0;
>   		}
>   
> -		if (dev->shared_resources.enable_mes)
> +		if (dev->shared_resources.enable_mes) {
>   			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>   						   pqn->q->gang_ctx_bo);
> +			if (pqn->q->wptr_bo)
> +				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +
> +		}
>   		uninit_queue(pqn->q);
>   	}
>   
> @@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);

