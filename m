Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E40EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62010E4A8;
	Wed, 21 Jun 2023 15:16:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EE310E4A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 15:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnpD8e/qUkSlA2Fjt/w3zr8xE7gl2LCqjFyi4Tkib45ulIchYcfq3xKrfThnBTYCUvmlL1yUTanNWJFq3nrzBvoyPPmXyBFslmOAhZecahFpssrqQ0wNpwnJMzKDDPAlOEOh/vOpcpF6X/sjasJXzxexqcTOI4ZHa+TUOtF5EmTdEv+hGXTlcyK3EH2ET/jAd8GR0SPKrhGjEZfjE8NBXVTL+ZJ9rnKeP6OiPnsRFfLvb/ITo0WDNxakjkEVCQqZher++xC1N4PqBvAZqSAQLF/ug+LuTnItUur4LnjcY/fDW/3ejmBldL7ZLWpBGpc264E9AHSs92jNK6ZbTzxWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB/sVvCGRRVxNRX00/6ATdUWz9tZSE5t+unEhMYhq8o=;
 b=ZiiXZz7B+yfh4f218Ph7Fo5R4nvhtcE922yXGOdi+lbqewNrv9utr/sSZIC+9XXwk3xYezddyc3HpytCfCdMsK4JqzV+tfj8klc12yTPuIgL6CIBVVKHurtEnIB06pZ5a2iHpnqqnqRmjerNNcy7nzY2QyJkKx+pqbw6Ry4RZVQJp0ejyC32NI4CqaK6QoWqQqjsVorHQp47f84s9dhnIGDSmye0YlTvoZ6+HSKlGooKaO/DfxY/vhBl+tmelpBFeFsRMQCCk0409s/41fFBteIkjL1SMOPn0+IjdRo86Ed24hXkakRnk7ilesA135wxCuQcQaLPCscf3cfhEq1aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB/sVvCGRRVxNRX00/6ATdUWz9tZSE5t+unEhMYhq8o=;
 b=vQsYBHDjKefg6ZoM1W+K5zghH7/csLrBQSgYiVNdpuOV2X8jOJlhvZFzejRcg1MEG0SIpreSc/bqgqUKg+Vj/oSzpu7ZbrNaXvlifFSyOinscbTMkxM/iWg/c1yBdXaVHi+g9eovhP3ouKJTf7pl8cWVyRAAbmxJwcYCK0RKwrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 15:16:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:16:19 +0000
Message-ID: <a373e7e8-1cb6-44d8-ea75-0e90bfe55e39@amd.com>
Date: Wed, 21 Jun 2023 11:16:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Forbid kfd using cpu to update pt if vm is
 shared with gfx
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230621094623.1357399-1-YuBiao.Wang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230621094623.1357399-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: f1258dcd-8127-4827-1fed-08db726a7727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Bs4okwu2UekkUWK6cU+3nXe5Q8HGNnaafJc9DjyYIu9CXXV+J6jmbhnqnjnYoBOGDL4zxWXuNmH+Pdcu2NmNIOQV8nrmsChvuzG31Y+N0PL4tSuRE7kViLjAAkv+NtQul8lWkPEpuU3XQkY2raLEtRHjN8JZhoHqy1I+eKKvIjR2B+hnBr2m/+UDH08Z8jj6mlyn29KgX9XUXoTDUrfx8VE0QuSDEMLjNFAPvuHXlQTKRQQnTSb+uY1VFg1HYYOeQNS6A5CZngLfTHXFDPkHXd7PpflzkwP/udq7Xt6sKZPlypitT2aiCdfpgThOlHJTZUcZTJKs3f03si/xUCQaLmMiruo4PSmrc9Q2wx8xpx1rs13p4DnLuRpvZVKubjO/MKB0czc3j3cerZODZVybQxnvV5/ZyECseVWC153oS0CDQl2RTRBB4TTPiNcOHrxENLKOtGCafh1MOCDouauNT4LPoBxnvxTtcFcPmFVzwTygKbgYt1SVarzQNAiuHadLXr9ZeXqOtPAtj57G7xmZkL77ntSsgnq1gx1kZU4u2z+3uq5n8nsAIEfJtAdeThATMjyyw233bNlnce3bfUGCP/mtMJ+6712iukI9sqcfFIaroNQp48M77mM7pbQYj2O2Mijrg5Q7wz3AyUgL5avEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(66476007)(8676002)(83380400001)(31696002)(31686004)(6486002)(54906003)(6666004)(316002)(38100700002)(8936002)(36756003)(26005)(86362001)(4326008)(186003)(6512007)(6506007)(41300700001)(5660300002)(66946007)(2616005)(66556008)(44832011)(2906002)(15650500001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm92N3I5QmtrZmNHSHdmU3NOSUJ1eC9uRGF2SGlVWTlxMlFnQ1dTWEFMbUo2?=
 =?utf-8?B?NkZnZG1zU2txTDFCNUV1dnA4d0xVUmhNSlhEMEpYeGdoWDRuZnVVM0pINnQ2?=
 =?utf-8?B?Y2N6UVJDK1VVdnpUYWwrRDQ5YlN4aGgydnQrL0xwanRzWGcxU2l1TFk3NTFk?=
 =?utf-8?B?eDkyVCs4UEphd2R4V1RGMXQzZExEZDVMV3pSM1h0Rkd5SzRpL0puKyt2VHZX?=
 =?utf-8?B?SzFjU25KcXNxZnFpQ1hxc0FJZlQ5MUVYY3V3N2d2cVU1dnR2Y05leTd5V0ow?=
 =?utf-8?B?Mm9ZRDQ3c0hHNFM1M2cyUzRmVWtDbTFCS3RERG1JMnpTM2tucGJlVmVsMHlO?=
 =?utf-8?B?YzBsWk5tV3gzS3Bwci9Ga2o0VVFpQ2FNalNKU2JwZnZOd3I5WlF5MGVYZEds?=
 =?utf-8?B?RXo5cmNsZG03bkhPakFXMjF5cTV5WG9Kcktxd1pXNzJQellFL29Td0tvUGtB?=
 =?utf-8?B?QzJ6bkFFbG54SmoyS0dFNndVL0dDbkFnd1RTYnh2WkJGL0U0ditSRXVaZDZQ?=
 =?utf-8?B?bDcvc3VqN1JPNXo0RGFETlNhc1h0NDVMWitYMWVFaTR5ejdoRURZMXF1YVVV?=
 =?utf-8?B?OWxwK3g2NEpxbUdzQlJ1ME1KSGtJMzEzNjB3VE9vNkdjRUFBckRVSjBCUW9x?=
 =?utf-8?B?d2pEZzQ4aVRvcko4OHdsS1NRUFFsQm4zWG5lYTQvREtMRXpYWW1wb0YvVmsy?=
 =?utf-8?B?ZHpvcFJRRVVmOW5IR2lNdThFZG94RkM1V0dQZGZPeXdBRCsxV29DZE1jOVhR?=
 =?utf-8?B?YTlXd3VqMjJsNUZobCtFMTNuTjFrZDhKVncvZ0t5N2NpT1NqUHlZUXVTNVZI?=
 =?utf-8?B?V2tFSzFrd2dDQzB5a3p3VUNMWXZqdWV0bjVHL0VXWGtvRGd4eUNpODB6bk5t?=
 =?utf-8?B?V3g0dThFczJmdm9XaHo1bmNaM1YwVUZ0TjY2aGFmbEM2R2Z0b3liQkY2RVI0?=
 =?utf-8?B?R2F5RGZxUCtkaXpnY1JkRXdvanB5TzEyZE9lTGJDa29lVllRRGl5bmIzNDFa?=
 =?utf-8?B?djJ1djduZnNjb2xYb0pXZjZhVnlQT2tFTlQ0cEV4WG0rWXdFbVdTNFRwNkd2?=
 =?utf-8?B?RG0yNUtIekEwNWx4LzBxQmFTLzRqbHJ6RXI1SmVYRDlhbGRic2dqQXVzaEhW?=
 =?utf-8?B?ZjU5TTNibGhiUGxONld3NWkrbzNCclNpdVprS3ZCL0YxZVlWRzV2anJ4RnRD?=
 =?utf-8?B?bkV3Y2h5dkxUeHJhQUxKbGZud0ZsdDRxMFBqTnhYYkpUcnF4ZlUvQkJXYzdL?=
 =?utf-8?B?NkFDYWdKOGRPaEJjVE9MU0NNcU82WGhPZGdob2U0RU5jUGh2MXBpN1QzTnlI?=
 =?utf-8?B?cXVHSVRYV05kZXNnN084bWRkL2VPVC92M0IxdTFZR21PRjZyTTAxRTdHVUNy?=
 =?utf-8?B?NndJaUUybGttOUZaRlllNEttWlJtSTR5STkxN0FxdkNsbncwbmkyZndxWldn?=
 =?utf-8?B?SkZ4RTc2bmNjbGFyaUY0TVRkaXlMNTBGSG9veFlLeUY1TmlucHpEQ3B0MGlV?=
 =?utf-8?B?aEtmZ3liazRPN0xmckNHYU5XbGZ6Y1dwU2tVTXVKS3FjSEhib1hOUE8rSkN0?=
 =?utf-8?B?ZytFdnhrWVhjOTZvaGE5cE9RVnZaR0JZNUFraXZrajhHcU5JVGVMVnJKWktx?=
 =?utf-8?B?WHVlNkM1eUpQUXZNMUFZWmlxK1c0eXZjUTZsdjF5UzRoMUxGOFlxM2IybnVW?=
 =?utf-8?B?Z0ViM3B0S1phbjRFRzh1cHc3dEFwczhkU2llcTNtbS8vb3YwZHRnTVlqZzZW?=
 =?utf-8?B?Y3p3eTVIT0ZWMFhFWWdPY3gxNGZMalhhcTl4aGRCa0Fuenk3Z1QwUUIxcVIy?=
 =?utf-8?B?eGErWkNEYzJNbDRzc2hSdTV4ODF2Z3FPYndPRnBNN1kzZ3I2N2Jqei82blBv?=
 =?utf-8?B?MS9KcW1rUTdFV0dwUkNoOEM2ZWNRQlJ4UWMreUZJSlh1MXhYUnF2c29tVitY?=
 =?utf-8?B?U2F3b0lLbVVMSXR0cmJFQ0hkbnkwamtLK3EwdXRMYmZ5Y3RJUFl6bzJDcjYy?=
 =?utf-8?B?L1U0SnlpeHhXMU14ZEsxdkhzRlhOcnZCZEZELzM4dTFxMy81SXJpWVZ1VVZU?=
 =?utf-8?B?OUpqMlJJM2M5TFJRcGxkSlljTlpJS24xbi9tZjlmZjVtRDVSUUh1TWFua3p2?=
 =?utf-8?Q?T0sBYwOrqTMLq9dJlbaTf5E1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1258dcd-8127-4827-1fed-08db726a7727
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:16:19.5806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFj9SKfIYZG5MOZRZqji004AOb6n4tGS145bX7ggc1CzCfqjQ8v97mPWQphqfXak/pJgGo+uyFjbEItAWqEHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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
Cc: Xiaogang.Chen@amd.com, Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can we change the flags if needed. E.g. see what 
amdgpu_bo_pin_restricted does:

         if (!(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS))
                 bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
         amdgpu_bo_placement_from_domain(bo, domain);

This shouldn't really change anything about the BO placement because we 
only enable CPU page table updates on large-BAR GPUs by default. 
Alternatively, we could create VM BOs with 
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED on large-BAR GPUs to make it 
possible to switch to CPU page table updates for compute VMs.

Regards,
   Felix


Am 2023-06-21 um 05:46 schrieb YuBiao Wang:
> If a same GPU VM is shared by kfd and graphic operations, we must align
> the vm update mode to sdma, or cpu kmap will fail and cause null pointer
> issue.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 291977b93b1d..e105ff9e8041 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2239,6 +2239,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
>   	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
> +	struct amdgpu_bo *bo = vm->root.bo;
>   	int r;
>   
>   	r = amdgpu_bo_reserve(vm->root.bo, true);
> @@ -2265,6 +2266,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	/* Update VM state */
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
> +
> +	if (bo && !(bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
> +		vm->use_cpu_for_update = false;
> +
>   	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>   			 vm->use_cpu_for_update ? "CPU" : "SDMA");
>   	WARN_ONCE((vm->use_cpu_for_update &&
