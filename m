Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA01C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 17:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420F510E31A;
	Mon, 28 Aug 2023 17:33:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F96610E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 17:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je5vk8OhprESnRZm1V4dior4+QVYgUQJT8NqUMRevxtAuieZRiyDV4gj7DPRKU73RxooXYlT/K8v7b75nJthgAtdsOVJDVGPO+X4Hxg+avUZTWZpuEDBO2V2v1kL/9Ya+Sbt2R6/6jcbJoxxMoljehovpUe7OZyIryGy3ztHMyCa71NEeZ4xKoUUN0ceRFFxfIYiR57wK3zFqqd+5Jv1T4/uBIug+vjXtSNJGB2ZafvlsnTiaosN3BkZXAdgPs6f4hdaoJ1enUyzoMtNVqpHq8F+p9h71obzRHlcb9/11Cb0ST15SErnhvV8zTPgI9tEpExew7n2sVb+7OodxB2oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq0yyHVdotuRx+YINbEtId+gosqESP8ONqaM2usLI4g=;
 b=XR0PHT48oEUsqXI2k4T9LRNvvlTD0fQlwdGMnlhAdbE2pziRs+UwxFUDc/+wnDh9eGYVJIT67BAOYsnfUcvaaEnQJtU+af/cYabfyM4CmJgdsb6oaoaks1/aDhsuTkSi7yIESaDM32thHHg8LPw3kTbmnlqABRMR6L8q1tkbs7X5MJZDifqn7pOawQUJ1UPx5dFRmJWj4VOY3YsOJi2mHBbmwU3GdW6t06HCnorTUI6JY6ETvDIPKE1arqLOqUSt1vBpe6+ux8Kbv8rUU9HCP8x+lD0EsesO7rFaafSYrunlfRYxIO/bnoC8VM7PwAuh0p0Wj6h6Z6IkbKJcZwV4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq0yyHVdotuRx+YINbEtId+gosqESP8ONqaM2usLI4g=;
 b=x+pHmuY3iC70+sgQ96bSA8U0g6aoyzL9Y8QHDdHOvyX4jczoXGLs4sbjfgDeVaijUvvvCki2NzYWI8tDhktf9zNoevCVV02KoT0yRf9hsL/kJvfRNHNIqx9K+eZL8OdDp+r054jNbtVzfHv5vfpa2Z+SD/PwTLg/HGN36iiKwPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 17:33:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:33:53 +0000
Message-ID: <4f63d3b2-6dbf-4986-9fdf-9dbd15bee63c@amd.com>
Date: Mon, 28 Aug 2023 13:33:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdkfd: Replace pr_err with dev_err
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230826134148.1735570-1-asad.kamal@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230826134148.1735570-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::29)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 52781471-adcb-4530-e4e3-08dba7ecf2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9M4jbcqQw6bzv8QsTK0tj/dJknPfj4WDZbXcT9WnnSbsM52X1ur7VgxGBkflzfmcIGd4DiOuXP6pJTmrDf7nSYtdTU9LH5Ljot4FadkbhArg4vOE2NRx7ny/+sFMi1AoLFzyM9cIKVIyvPMI4ocZUBPRZ3X5ia1HXo7hG8MaNsXXLakeLPlcui37yvnH8AcOaoW9htv8Q2ZCJ2frjIWwNG8Z7dO3TQp/tqz6TpxUV1UIeFDteP1YoyO4Zon2NbDoSQie51lThy7fxNaBFimze+1LD7gvI4nL9sera6RBm+5mzn1bDH/mf/JKhHAH4nlFTCtAv3iPP72VGDTG+YzRQeJYn+WN5AL/H3z0nb+t/0X0qkW/v5ucNbzmLp7TdDsiLnjR04/eYyRCcvDx9Qo5oT+Tl/18/NB3Y/Cmp6+o/CX5yiaYEminSXnNMyZZV2bFNYIXcGBixml9H9KzAvkiu87syReulSvjp1mRh6Ie333f3VYIDPS2h9kBYxrpkXYSbEksqpgEyD3P/GCkJR7JHbCxH9qWp34B8ZLrno1EqpIZTy4k9g5YmE1Vqk/3jcO6eKdaztMKXke52hcNKjHdiCDexQH4cxEceLvX9rIZnW+3xEk6IHvqHrx7WiSfITZDe3tcFSl2nQFJgzsQeNXqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(31686004)(66899024)(6512007)(6506007)(36916002)(6486002)(36756003)(86362001)(31696002)(38100700002)(2616005)(2906002)(30864003)(26005)(83380400001)(53546011)(478600001)(41300700001)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVTckZTWEMrUWNkV1kyUCt3Sk9CbUFBRkJyNmw4QUE1dVZLMUNJKzAzaDNC?=
 =?utf-8?B?cmdtalN5UkxUSm5JS0F5UzZNcUVQUGlsblhIMys3MFZMM0JRRTFoZkxSMGNU?=
 =?utf-8?B?RCszeVhlQVBuUXcwalBqVnZzU1dPVHcrRE41Wk1sak0zSW9KaVpsSlpRbmVp?=
 =?utf-8?B?VmxQcFZNcmhmZTV5R3lYS0dHNU5Rb0QvYWxEd2NSRkRNTnpPQ3lOdHNEbU5P?=
 =?utf-8?B?dkRMTXZrRWM5ZEhEZXI2TVhJMkowZkNLNC9lU0tBdi8yY2MwY293Y0tEc3VR?=
 =?utf-8?B?V3EwSlFKL3MrVVV5dGNjeWI0eDBYMUhVV2JzMHdpUkJzMVBneUNBQldCQkhY?=
 =?utf-8?B?eW9ZR1NhVHQ4S1NtUGJDYm03MGRvZUtPWFo4UEdKUXR2VTI4L0hGcHBybUg4?=
 =?utf-8?B?VVJRY29Zbit5M2hlUjdxUUMwK2pVR0JIeEhwSEVKV25QSEk1QUF5Q0FMNXFi?=
 =?utf-8?B?QTNISUwxc0hPNEo0alczaXZLYXYveFhVOVVEdXlKeG5EQU9qZlE3UUhhT0lh?=
 =?utf-8?B?TENDYTFXVitXd0MrODlkdHAramJUNHhxRWdsd2FWa2VINW9XazdKN1lpUktQ?=
 =?utf-8?B?NjZmMEkrakFuMnd3dXp2R2dVQ2VmTFFhZmgwNW1qZm8wcVRCU2w0NHFPTnM4?=
 =?utf-8?B?WEx1NFQzSllCdWl2bHhncGRzeDg4UzFhV2EycldMajQrMjAwbkM1MG1DVGFy?=
 =?utf-8?B?WVZFK040TWVLRS9pRnp1S1hnQm9RT3ZVbDk5R3hzWEl5QjNuaGpTNU1hNExK?=
 =?utf-8?B?QjlGSVY4ekp0Y0QxOTRkN0NlVFcra1RvVkpvY1puRERFNm1JQllGUGdWQlNB?=
 =?utf-8?B?c2JQLzNZaTJBVWVsVkQ1dWFGT3pqai8vUGFHTytLbmNWQzRYM3dtaTUvR2Js?=
 =?utf-8?B?a3VXeWhRWURZRmdwNy9uZWFlTzBmVmNmVDBVNWZJUElOcHNselcxWTZhSHdZ?=
 =?utf-8?B?WDh4TUhRd1FQYWpZNmh4U2VMWFlRcFgyeUo2M0Y0dmJyeWUveDF2d3pMMk44?=
 =?utf-8?B?ZFNZdjkrY3ozbmhKR2RONXhqNm8rODRnczVxckpFTFFwV0xFUUdxNFJPZmFF?=
 =?utf-8?B?cWJpVHpXd21ncXo1QnVxeE9QN3BqdXRzWFBMMFN3aFFJbEdZajNjYm15VTNC?=
 =?utf-8?B?MHpHM3Q2UjFkVHh5UWdLV0VMMHNSaVZ3aDlKVUg5bTBOM1o4a2Y3VzJKQy85?=
 =?utf-8?B?T3N0aCs1MDU0UVRvV3JEcmNkWHk2MHhWSmgvUGhGcXA2SFg4Q2hYcEU5TVR1?=
 =?utf-8?B?MFRHK1BNL3dBaUs5SE9Oblc0MTFqeVN2a1NjdFVHa1lrSnJNNFJiVUxDZXp3?=
 =?utf-8?B?T2dmWGZ3RXNJTXlNTE9GYmhjZnBPYjFBRVBHd3d5UWpvdzNxSHlUNmdtWDFx?=
 =?utf-8?B?RGVPU1hMcnZ3bjBFeFpQRjRad1N0cExXOEZ2WDJQME9uMzYyUW41enZlSHFk?=
 =?utf-8?B?Wmlsb1MydTJKaHUvenpWQldsL3hZLzRkVzlFV2J0NFJ6OXJsU2ZMNmlDSHFp?=
 =?utf-8?B?dnU4VkxJakRtUlRaSFAreTdlWXhEekVqdlJEVS9ySkVHRFZta2VWMG5Vckl5?=
 =?utf-8?B?V1RPVVppbzhVYnBxenFZZFM0QmwyV2NKTlpxc3ZhVEVKVFV3TTlNdG9tbFZP?=
 =?utf-8?B?TnR3cUNGeWE0OUliUUlVTVdDNk5RaTk3clRJOVNaWVM1VWVqWW1zdkZDK1Fq?=
 =?utf-8?B?S290TUFjSzVDQ0FCdUFkRk5HRVBCQUE0WFlEZW5lUXp0N0YzWEZXalZGWnc4?=
 =?utf-8?B?Y281WGp0UUxuRUQwZHdlZkd2ZVE4WmtzaFVzNFg2NmxONmpsWld6ckNrK2ds?=
 =?utf-8?B?aDk4eTU0QlR5SkFGdjZJTkdYaU04K3M0MWF0NWZlYWNMU2dObnR5b3F2UXhH?=
 =?utf-8?B?NDBjWGVaV3NQdE02b1JZTmpMM1dnd1UwMVY2ZzZGa1Byc2V3cWg3OTM1QUtN?=
 =?utf-8?B?RjhYbEtDWEtsM3F6ZFloZ1l3VHN5cGxDc0NLVkh4ZUpEZmlMcFAwOUtmYjBV?=
 =?utf-8?B?dW1nR3B4YlA4ZWtQTkEwM0JPM3I1aDlseUliSko5UldqMk12L011MlVpN0Vj?=
 =?utf-8?B?ejd6QXhuZDBEcGNqVnQ0MExxbG95NUdGN2xtdHBwN25Obmh0czRTZ1VCSit2?=
 =?utf-8?Q?75no6I0yBUVgtichwE08oV1VA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52781471-adcb-4530-e4e3-08dba7ecf2f1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:33:53.5988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdPMI/3XjwMK0nwQbX4mQKuabrdgo9M73QFgPqaw9Xet0cBPI9Ak5jU9OFZ/qiK7rsEhoSK2Hrwm2m+VM/Hqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-26 09:41, Asad Kamal wrote:
> Replace pr_err with dev_err to show the bus-id of
> failing device with kfd queue errors
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 116 +++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
>   2 files changed, 71 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b166f30f083e..cd6cfffd6436 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -232,8 +232,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
>   	if (queue_type < 0) {
> -		pr_err("Queue type not supported with MES, queue:%d\n",
> -				q->properties.type);
> +		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
> +			q->properties.type);
>   		return -EINVAL;
>   	}
>   	queue_input.queue_type = (uint32_t)queue_type;
> @@ -244,9 +244,9 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>   	amdgpu_mes_unlock(&adev->mes);
>   	if (r) {
> -		pr_err("failed to add hardware queue to MES, doorbell=0x%x\n",
> +		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
>   			q->properties.doorbell_off);
> -		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
>   	}
>   
> @@ -272,9 +272,9 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	amdgpu_mes_unlock(&adev->mes);
>   
>   	if (r) {
> -		pr_err("failed to remove hardware queue from MES, doorbell=0x%x\n",
> +		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>   			q->properties.doorbell_off);
> -		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
>   	}
>   
> @@ -284,6 +284,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct device_process_node *cur;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct qcm_process_device *qpd;
>   	struct queue *q;
>   	int retval = 0;
> @@ -294,7 +295,7 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   			if (q->properties.is_active) {
>   				retval = remove_queue_mes(dqm, q, qpd);
>   				if (retval) {
> -					pr_err("%s: Failed to remove queue %d for dev %d",
> +					dev_err(dev, "%s: Failed to remove queue %d for dev %d",
>   						__func__,
>   						q->properties.queue_id,
>   						dqm->dev->id);
> @@ -443,6 +444,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd,
>   			struct queue *q)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int allocated_vmid = -1, i;
>   
>   	for (i = dqm->dev->vm_info.first_vmid_kfd;
> @@ -454,7 +456,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   	}
>   
>   	if (allocated_vmid < 0) {
> -		pr_err("no more vmid to allocate\n");
> +		dev_err(dev, "no more vmid to allocate\n");
>   		return -ENOSPC;
>   	}
>   
> @@ -510,10 +512,12 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>   				struct qcm_process_device *qpd,
>   				struct queue *q)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
> +
>   	/* On GFX v7, CP doesn't flush TC at dequeue */
>   	if (q->device->adev->asic_type == CHIP_HAWAII)
>   		if (flush_texture_cache_nocpsch(q->device, qpd))
> -			pr_err("Failed to flush TC\n");
> +			dev_err(dev, "Failed to flush TC\n");
>   
>   	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>   
> @@ -708,7 +712,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   	pr_debug("Killing all process wavefronts\n");
>   
>   	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
> -		pr_err("no vmid pasid mapping supported \n");
> +		dev_err(dev->adev->dev, "no vmid pasid mapping supported\n");
>   		return -EOPNOTSUPP;
>   	}
>   
> @@ -729,7 +733,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   	}
>   
>   	if (vmid > last_vmid_to_scan) {
> -		pr_err("Didn't find vmid for pasid 0x%x\n", p->pasid);
> +		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
>   		return -EFAULT;
>   	}
>   
> @@ -821,6 +825,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   {
>   	int retval;
>   	uint64_t sdma_val = 0;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mqd_manager *mqd_mgr =
>   		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> @@ -831,7 +836,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>   							&sdma_val);
>   		if (retval)
> -			pr_err("Failed to read SDMA queue counter for queue: %d\n",
> +			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
>   	}
>   
> @@ -850,6 +855,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   			struct mqd_update_info *minfo)
>   {
>   	int retval = 0;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct mqd_manager *mqd_mgr;
>   	struct kfd_process_device *pdd;
>   	bool prev_active = false;
> @@ -875,7 +881,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   			retval = remove_queue_mes(dqm, q, &pdd->qpd);
>   
>   		if (retval) {
> -			pr_err("unmap queue failed\n");
> +			dev_err(dev, "unmap queue failed\n");
>   			goto out_unlock;
>   		}
>   	} else if (prev_active &&
> @@ -894,7 +900,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   				 KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
>   				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
>   		if (retval) {
> -			pr_err("destroy mqd failed\n");
> +			dev_err(dev, "destroy mqd failed\n");
>   			goto out_unlock;
>   		}
>   	}
> @@ -1088,6 +1094,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   				      struct qcm_process_device *qpd)
>   {
>   	struct queue *q;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct kfd_process_device *pdd;
>   	int retval = 0;
>   
> @@ -1121,7 +1128,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = remove_queue_mes(dqm, q, qpd);
>   			if (retval) {
> -				pr_err("Failed to evict queue %d\n",
> +				dev_err(dev, "Failed to evict queue %d\n",
>   					q->properties.queue_id);
>   				goto out;
>   			}
> @@ -1225,6 +1232,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
>   	struct queue *q;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct kfd_process_device *pdd;
>   	uint64_t eviction_duration;
>   	int retval = 0;
> @@ -1265,7 +1273,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = add_queue_mes(dqm, q, qpd);
>   			if (retval) {
> -				pr_err("Failed to restore queue %d\n",
> +				dev_err(dev, "Failed to restore queue %d\n",
>   					q->properties.queue_id);
>   				goto out;
>   			}
> @@ -1474,18 +1482,19 @@ static void pre_reset(struct device_queue_manager *dqm)
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   				struct queue *q, const uint32_t *restore_sdma_id)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int bit;
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>   		if (bitmap_empty(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
> -			pr_err("No more SDMA queue to allocate\n");
> +			dev_err(dev, "No more SDMA queue to allocate\n");
>   			return -ENOMEM;
>   		}
>   
>   		if (restore_sdma_id) {
>   			/* Re-use existing sdma_id */
>   			if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap)) {
> -				pr_err("SDMA queue already in use\n");
> +				dev_err(dev, "SDMA queue already in use\n");
>   				return -EBUSY;
>   			}
>   			clear_bit(*restore_sdma_id, dqm->sdma_bitmap);
> @@ -1504,13 +1513,13 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   				kfd_get_num_sdma_engines(dqm->dev);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		if (bitmap_empty(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
> -			pr_err("No more XGMI SDMA queue to allocate\n");
> +			dev_err(dev, "No more XGMI SDMA queue to allocate\n");
>   			return -ENOMEM;
>   		}
>   		if (restore_sdma_id) {
>   			/* Re-use existing sdma_id */
>   			if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
> -				pr_err("SDMA queue already in use\n");
> +				dev_err(dev, "SDMA queue already in use\n");
>   				return -EBUSY;
>   			}
>   			clear_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap);
> @@ -1562,6 +1571,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
>   {
>   	int i, mec;
>   	struct scheduling_resources res;
> +	struct device *dev = dqm->dev->adev->dev;
>   
>   	res.vmid_mask = dqm->dev->compute_vmid_bitmap;
>   
> @@ -1582,7 +1592,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
>   		 * definition of res.queue_mask needs updating
>   		 */
>   		if (WARN_ON(i >= (sizeof(res.queue_mask)*8))) {
> -			pr_err("Invalid queue enabled by amdgpu: %d\n", i);
> +			dev_err(dev, "Invalid queue enabled by amdgpu: %d\n", i);
>   			break;
>   		}
>   
> @@ -1625,6 +1635,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   
>   static int start_cpsch(struct device_queue_manager *dqm)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int retval;
>   
>   	retval = 0;
> @@ -1671,7 +1682,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   		retval = pm_update_grace_period(&dqm->packet_mgr,
>   						grace_period);
>   		if (retval)
> -			pr_err("Setting grace timeout failed\n");
> +			dev_err(dev, "Setting grace timeout failed\n");
>   		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
>   			/* Update dqm->wait_times maintained in software */
>   			dqm->dev->kfd2kgd->build_grace_period_packet_info(
> @@ -1881,15 +1892,17 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	return retval;
>   }
>   
> -int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
> -				uint64_t fence_value,
> -				unsigned int timeout_ms)
> +int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
> +			      uint64_t fence_value,
> +			      unsigned int timeout_ms)
>   {
>   	unsigned long end_jiffies = msecs_to_jiffies(timeout_ms) + jiffies;
> +	struct device *dev = dqm->dev->adev->dev;
> +	uint64_t *fence_addr =  dqm->fence_addr;
>   
>   	while (*fence_addr != fence_value) {
>   		if (time_after(jiffies, end_jiffies)) {
> -			pr_err("qcm fence wait loop timeout expired\n");
> +			dev_err(dev, "qcm fence wait loop timeout expired\n");
>   			/* In HWS case, this is used to halt the driver thread
>   			 * in order not to mess up CP states before doing
>   			 * scandumps for FW debugging.
> @@ -1908,6 +1921,7 @@ int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int map_queues_cpsch(struct device_queue_manager *dqm)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int retval;
>   
>   	if (!dqm->sched_running)
> @@ -1920,7 +1934,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
>   	retval = pm_send_runlist(&dqm->packet_mgr, &dqm->queues);
>   	pr_debug("%s sent runlist\n", __func__);
>   	if (retval) {
> -		pr_err("failed to execute runlist\n");
> +		dev_err(dev, "failed to execute runlist\n");
>   		return retval;
>   	}
>   	dqm->active_runlist = true;
> @@ -1935,8 +1949,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				uint32_t grace_period,
>   				bool reset)
>   {
> -	int retval = 0;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct mqd_manager *mqd_mgr;
> +	int retval = 0;
>   
>   	if (!dqm->sched_running)
>   		return 0;
> @@ -1959,10 +1974,10 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
>   				KFD_FENCE_COMPLETED);
>   	/* should be timed out */
> -	retval = amdkfd_fence_wait_timeout(dqm->fence_addr, KFD_FENCE_COMPLETED,
> -				queue_preemption_timeout_ms);
> +	retval = amdkfd_fence_wait_timeout(dqm, KFD_FENCE_COMPLETED,
> +					   queue_preemption_timeout_ms);
>   	if (retval) {
> -		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
> +		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
>   		kfd_hws_hang(dqm);
>   		return retval;
>   	}
> @@ -1977,7 +1992,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	 */
>   	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>   	if (mqd_mgr->read_doorbell_id(dqm->packet_mgr.priv_queue->queue->mqd)) {
> -		pr_err("HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
> +		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
>   		while (halt_if_hws_hang)
>   			schedule();
>   		return -ETIME;
> @@ -1987,7 +2002,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
>   		if (pm_update_grace_period(&dqm->packet_mgr,
>   					USE_DEFAULT_GRACE_PERIOD))
> -			pr_err("Failed to reset grace period\n");
> +			dev_err(dev, "Failed to reset grace period\n");
>   	}
>   
>   	pm_release_ib(&dqm->packet_mgr);
> @@ -2061,6 +2076,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	struct mqd_manager *mqd_mgr;
>   	uint64_t sdma_val = 0;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
> +	struct device *dev = dqm->dev->adev->dev;
>   
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
> @@ -2068,7 +2084,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>   							&sdma_val);
>   		if (retval)
> -			pr_err("Failed to read SDMA queue counter for queue: %d\n",
> +			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
>   	}
>   
> @@ -2349,6 +2365,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   {
>   	int retval;
>   	struct queue *q;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct kernel_queue *kq, *kq_next;
>   	struct mqd_manager *mqd_mgr;
>   	struct device_process_node *cur, *next_dpn;
> @@ -2382,7 +2399,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   			if (dqm->dev->kfd->shared_resources.enable_mes) {
>   				retval = remove_queue_mes(dqm, q, qpd);
>   				if (retval)
> -					pr_err("Failed to remove queue %d\n",
> +					dev_err(dev, "Failed to remove queue %d\n",
>   						q->properties.queue_id);
>   			}
>   		}
> @@ -2437,12 +2454,13 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   static int init_mqd_managers(struct device_queue_manager *dqm)
>   {
>   	int i, j;
> +	struct device *dev = dqm->dev->adev->dev;
>   	struct mqd_manager *mqd_mgr;
>   
>   	for (i = 0; i < KFD_MQD_TYPE_MAX; i++) {
>   		mqd_mgr = dqm->asic_ops.mqd_manager_init(i, dqm->dev);
>   		if (!mqd_mgr) {
> -			pr_err("mqd manager [%d] initialization failed\n", i);
> +			dev_err(dev, "mqd manager [%d] initialization failed\n", i);
>   			goto out_free;
>   		}
>   		dqm->mqd_mgrs[i] = mqd_mgr;
> @@ -2552,7 +2570,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.checkpoint_mqd = checkpoint_mqd;
>   		break;
>   	default:
> -		pr_err("Invalid scheduling policy %d\n", dqm->sched_policy);
> +		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
>   		goto out_free;
>   	}
>   
> @@ -2590,7 +2608,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		goto out_free;
>   
>   	if (!dev->kfd->shared_resources.enable_mes && allocate_hiq_sdma_mqd(dqm)) {
> -		pr_err("Failed to allocate hiq sdma mqd trunk buffer\n");
> +		dev_err(dev->adev->dev, "Failed to allocate hiq sdma mqd trunk buffer\n");
>   		goto out_free;
>   	}
>   
> @@ -2649,17 +2667,18 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
>   				struct qcm_process_device *qpd)
>   {
>   	int r;
> +	struct device *dev = dqm->dev->adev->dev;
>   	int updated_vmid_mask;
>   
>   	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> -		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
> +		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
>   		return -EINVAL;
>   	}
>   
>   	dqm_lock(dqm);
>   
>   	if (dqm->trap_debug_vmid != 0) {
> -		pr_err("Trap debug id already reserved\n");
> +		dev_err(dev, "Trap debug id already reserved\n");
>   		r = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -2695,19 +2714,20 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
>   int release_debug_trap_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int r;
>   	int updated_vmid_mask;
>   	uint32_t trap_debug_vmid;
>   
>   	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> -		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
> +		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
>   		return -EINVAL;
>   	}
>   
>   	dqm_lock(dqm);
>   	trap_debug_vmid = dqm->trap_debug_vmid;
>   	if (dqm->trap_debug_vmid == 0) {
> -		pr_err("Trap debug id is not reserved\n");
> +		dev_err(dev, "Trap debug id is not reserved\n");
>   		r = -EINVAL;
>   		goto out_unlock;
>   	}
> @@ -2844,6 +2864,7 @@ int resume_queues(struct kfd_process *p,
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   		struct device_queue_manager *dqm = pdd->dev->dqm;
> +		struct device *dev = dqm->dev->adev->dev;
>   		struct qcm_process_device *qpd = &pdd->qpd;
>   		struct queue *q;
>   		int r, per_device_resumed = 0;
> @@ -2894,7 +2915,7 @@ int resume_queues(struct kfd_process *p,
>   					0,
>   					USE_DEFAULT_GRACE_PERIOD);
>   		if (r) {
> -			pr_err("Failed to resume process queues\n");
> +			dev_err(dev, "Failed to resume process queues\n");
>   			if (queue_ids) {
>   				list_for_each_entry(q, &qpd->queues_list, list) {
>   					int q_idx = q_array_get_index(
> @@ -2946,6 +2967,7 @@ int suspend_queues(struct kfd_process *p,
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   		struct device_queue_manager *dqm = pdd->dev->dqm;
> +		struct device *dev = dqm->dev->adev->dev;
>   		struct qcm_process_device *qpd = &pdd->qpd;
>   		struct queue *q;
>   		int r, per_device_suspended = 0;
> @@ -2994,7 +3016,7 @@ int suspend_queues(struct kfd_process *p,
>   			grace_period);
>   
>   		if (r)
> -			pr_err("Failed to suspend process queues.\n");
> +			dev_err(dev, "Failed to suspend process queues.\n");
>   		else
>   			total_suspended += per_device_suspended;
>   
> @@ -3081,10 +3103,11 @@ void set_queue_snapshot_entry(struct queue *q,
>   
>   int debug_lock_and_unmap(struct device_queue_manager *dqm)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int r;
>   
>   	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> -		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
> +		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
>   		return -EINVAL;
>   	}
>   
> @@ -3102,10 +3125,11 @@ int debug_lock_and_unmap(struct device_queue_manager *dqm)
>   
>   int debug_map_and_unlock(struct device_queue_manager *dqm)
>   {
> +	struct device *dev = dqm->dev->adev->dev;
>   	int r;
>   
>   	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> -		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
> +		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3d9ce44d88da..b315311dfe2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1343,7 +1343,7 @@ int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
>   			   int *num_qss_entries,
>   			   uint32_t *entry_size);
>   
> -int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
> +int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>   			      uint64_t fence_value,
>   			      unsigned int timeout_ms);
>   
